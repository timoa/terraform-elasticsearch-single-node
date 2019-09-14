# Terraform Elasticsearch Single Node on AWS

Example of the creation of an AWS Elasticsearch single node with Terraform

## Includes

- Create an AWS Elasticsearch Service instance (managed by AWS)
- Deploy the Elasticsearch instance under a custom VPC
- Encryption with a KMS custom key (let you manage the usage of the KMS key)
- Accessible only from your office/home public IP

## Improvements

This project is just a minimal example of how to deploy an AWS Elasticsearch service instance with a single node with the minimum of security.

This Terraform module can also be improved by adding this changes:

- Support for multiple environments (distinct name and tags between environment)
- Support for Route 53 (by adding an alias to an existing Route 53 zone)

```bash
module "es-single-node" {
  source = "git::https://github.com/timoa/terraform-elastic-single-node/minimal-vpc"

  name                      = "es-single-node-example"

  # Need to be greater than t2 since it doesn't support encryption
  instance_type             = "m4.large.elasticsearch"

}
```
