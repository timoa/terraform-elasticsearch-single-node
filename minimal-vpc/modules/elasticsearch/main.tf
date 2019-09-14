resource "aws_elasticsearch_domain" "elasticsearch" {
  domain_name           = var.domain_name
  elasticsearch_version = var.elasticsearch_version

  encrypt_at_rest {
    enabled    = "true"
    kms_key_id = var.encryption_kms_key_id
  }

  cluster_config {
    instance_type            = var.instance_type
    instance_count           = "1"
    dedicated_master_enabled = "false"
    dedicated_master_count   = "0"
    zone_awareness_enabled   = "false"
  }

  access_policies = <<CONFIG
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "*"
        },
        "Action": "es:*",
        "Resource": "${var.my_public_ip}/32"
      }
    ]
  }
  CONFIG

  vpc_options {
    security_group_ids = [var.security_group]
    subnet_ids         = var.public_subnet
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
    "indices.query.bool.max_clause_count"    = "1024"
  }

  ebs_options {
    ebs_enabled = true
    volume_type = "gp2"
    volume_size = var.volume_size
  }

  snapshot_options {
    automated_snapshot_start_hour = "0"
  }

  # Tags
  tags = "${merge(var.tags, map(
    "Name", "elasticsearch-es",
    "Domain", var.domain_name
  ))}"
}