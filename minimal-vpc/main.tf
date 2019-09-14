terraform {
  required_version = ">= 0.12.8"
}

module "network" {
  source = "./modules/network"

  # Global
  aws_region = var.aws_region

  # VPC
  vpc_cidr      = var.vpc_cidr
  public_subnet = var.public_subnet

  # Security
  my_public_ip = var.my_public_ip

  # Tags 
  tags = var.tags

}

module "security" {
  source = "./modules/security"

  # Tags
  tags = var.tags
}

module "elasticsearch" {
  source = "./modules/elasticsearch"

  # Network
  vpc_id         = module.network.vpc_id
  security_group = module.network.elasticsearch_sg_id
  public_subnet  = module.network.public_subnets[0]

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