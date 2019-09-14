/**
 * Usage:
 *
 * module "es-single-node" {
 *   source = "github.com/timoa/terraform-elasticsearch-single-node/minimal"
 *
 *   # Your public IP to secure your Elasticsearch instance (required)
 *   my_public_ip    = "1.2.3.4"
 *
 *   # AWS Region where you want to deploy your Elasticsearch single node
 *   aws_region      = "eu-west-2"
 *
 * }
 */

module "security" {
  source = "./modules/security"

  # Tags
  tags = var.tags
}

module "elasticsearch" {
  source = "./modules/elasticsearch"

  # Global
  aws_region = var.aws_region

  # Security
  my_public_ip          = var.my_public_ip
  encryption_kms_key_id = module.security.elasticsearch_kms_key_id

  # Elasticsearch
  domain_name           = var.domain_name
  elasticsearch_version = var.elasticsearch_version
  instance_type         = var.instance_type
  volume_size           = var.volume_size

  # Tags
  tags = var.tags
}
