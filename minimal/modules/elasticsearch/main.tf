variable aws_region {}

# Get your current AWS account ID for the access policy (resource)
data "aws_caller_identity" "current" {}

resource "aws_elasticsearch_domain" "elasticsearch" {
  # Name of the Elasticsearch cluster (domain)
  domain_name = "${var.domain_name}"

  # Elasticsearch version (last supported by AWS is 6.3)
  elasticsearch_version = "${var.elasticsearch_version}"

  # Encryption of the Elasticsearch instance volume with a KMS CMK
  encrypt_at_rest {
    enabled    = "true"
    kms_key_id = "${var.encryption_kms_key_id}"
  }

  cluster_config {
    # Instance type of the data node in the cluster
    instance_type = "${var.instance_type}"

    # Number of instances in the cluster (single node = 1)
    instance_count = "1"

    # Useless since were are using only one node
    dedicated_master_enabled = "false"
    dedicated_master_count   = "0"

    # Clone of the node in antoher AZ
    zone_awareness_enabled = "false"
  }

  # Access policy that restricts the Elasticsearch access to your public IP only
  access_policies = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "es:*",
        "Principal": "*",
        "Effect": "Allow",
        "Resource": "arn:aws:es:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/${var.domain_name}/*",
        "Condition": {
          "IpAddress": {
            "aws:SourceIp": [
              "${var.my_public_ip}/32"
            ]
          }
        }
      }
    ]
  }
  POLICY

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "true"
    "indices.query.bool.max_clause_count"    = "1024"
  }

  ebs_options {
    ebs_enabled = true
    volume_type = "gp2"
    volume_size = "${var.volume_size}"
  }

  snapshot_options {
    # Hour during which the service takes an automated daily snapshot of the indices in the domain
    automated_snapshot_start_hour = "0"
  }

  # Tags
  tags = "${merge(var.tags, map(
    "Name", "elasticsearch-es",
    "Domain", "${var.domain_name}"
  ))}"
}
