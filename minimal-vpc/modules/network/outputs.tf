output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "ID of the VPC public subnet"
  value       = [module.vpc.public_subnets]
}

output "elasticsearch_sg_id" {
  description = "Elasticsearch security group ID"
  value       = module.elasticsearch_sg.this_security_group_id
}