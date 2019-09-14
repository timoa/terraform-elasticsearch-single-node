variable "aws_region" {}

variable "vpc_cidr" {}
variable "public_subnet" {}

variable "my_public_ip" {}

variable tags {
  type = "map"
}