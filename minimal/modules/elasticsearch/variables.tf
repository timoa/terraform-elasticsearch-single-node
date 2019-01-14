#Security
variable "my_public_ip" {}

variable "encryption_kms_key_id" {}

# Elasticsearch
variable "domain_name" {}

variable "elasticsearch_version" {}
variable "instance_type" {}
variable "volume_size" {}

variable tags {
  type = "map"
}
