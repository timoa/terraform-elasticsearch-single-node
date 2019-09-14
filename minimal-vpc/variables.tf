#################
# YOUR EXTERNAL IP
#################
# For security reason, the Elasticsearch instance will be limited to your external IP
variable "my_public_ip" {
  default = "2.28.193.187"
}

#################
# Global
#################
variable "aws_region" {
  description = "Region where the Elasticsearch instance will be deployed"
  default     = "us-east-1"
}

#################
# Network
#################

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet" {
  default = "10.0.1.0/24"
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
  description = "Elastic Search Service cluster Ec2 instance type."
  type        = "string"
}

variable "rest_action_multi_allow_explicit_index" {
  default     = "true"
  description = "Specifies whether explicit references to indices are allowed inside the body of HTTP requests."
  type        = "string"
}

variable "snapshot_start" {
  default     = 0
  description = "Elastic Search Service maintenance/snapshot start time."
  type        = "string"
}

variable "volume_size" {
  default     = "10"
  description = "Default size of the EBS volumes."
  type        = "string"
}

variable "volume_type" {
  default     = "gp2"
  description = "Default type of the EBS volumes."
  type        = "string"
}

#################
# Tags
#################

variable "tags" {
  description = "Tags to apply to all the resources"
  type        = "map"
  default = {
    Terraform = "true"
  }
}