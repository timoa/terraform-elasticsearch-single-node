/**
 * Usage:
 *
 * module "network" {
 *   source = "./modules/network"
 *   
 *   # Global
 *   aws_region        = var.aws_region
 *   
 *   # VPC
 *   vpc_cidr          = var.vpc_cidr
 *   public_subnet     = var.public_subnet
 *
 * }
 */

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "elasticsearch-vpc"
  cidr = var.vpc_cidr

  azs            = ["${var.aws_region}a"]
  public_subnets = [var.public_subnet]

  enable_dns_hostnames = true
  enable_nat_gateway   = false
  single_nat_gateway   = false
  enable_vpn_gateway   = false

  # Tags
  tags = merge(var.tags, map(
    "Name", "elasticsearch-vpc"
  ))

}

module "elasticsearch_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "elasticsearch-sg"
  description = "Security group that allows access to Elasticsearch only from your IP and all egress traffic"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "https-443-tcp"
      description = "Elasticsearch/Kibana"
      cidr_blocks = "${var.my_public_ip}/32"
    },
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      description = "Internet"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  # Tags
  tags = merge(var.tags, map(
    "Name", "elasticsearch-sg"
  ))

}