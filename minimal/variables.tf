#################
# YOUR EXTERNAL IP
#################
# For security reason, the Elasticsearch instance will be limited to your external IP
variable "my_public_ip" {}

#################
# Global
#################
variable "aws_region" {
  description = "Region where the Elasticsearch instance will be deployed"
  default     = "us-east-1"
}

#################
# Elasticsearch
#################
variable "domain_name" {
  default     = "elasticsearch-single-node"
  description = "Elastic Search Service cluster name."
  type        = "string"
}

variable "elasticsearch_version" {
  default     = "6.8"
  description = "Elastic Search Service cluster version number."
  type        = "string"
}

variable "instance_type" {
  default     = "m4.large.elasticsearch"
  description = "Elastic Search Service cluster Ec2 instance type. The t2 family doesn't supports encryption at rest"
  type        = "string"
}

variable "volume_size" {
  default     = "10"
  description = "Default size of the EBS volumes."
  type        = "string"
}

#################
# Tags
#################

variable "tags" {
  description = "Default tags to apply to all the resources"
  type        = "map"

  default = {
    Terraform = "true"
  }
}
