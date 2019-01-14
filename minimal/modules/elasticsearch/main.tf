variable aws_region {}

data "aws_caller_identity" "current" {}

resource "aws_elasticsearch_domain" "elasticsearch" {
  domain_name           = "${var.domain_name}"
  elasticsearch_version = "${var.elasticsearch_version}"

  encrypt_at_rest {
    enabled    = "true"
    kms_key_id = "${var.encryption_kms_key_id}"
  }

  cluster_config {
    instance_type            = "${var.instance_type}"
    instance_count           = "1"
    dedicated_master_enabled = "false"
    dedicated_master_count   = "0"
    zone_awareness_enabled   = "false"
  }

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
    automated_snapshot_start_hour = "0"
  }

  # Tags
  tags = "${merge(var.tags, map(
    "Name", "elasticsearch-es",
    "Domain", "${var.domain_name}"
  ))}"
}
