# Terraform module - AWS Elasticsearch Service Single Node

Example of a minimal Terraform module to deploy an AWS Elasticsearch Service instance with a single node.

Minimal doesn't have to be unsecure 😄

It supports encryption at rest with a custom KMS key and IAM Access Policy that gives access only to your public IP.

> This module has been made to provide an example but in a real world scenario, it will be better to run your Elasticsearch instance under a custom VPC with only access from your EC2 instance(s) or AWS services instead of facing to Internet. Kibana can be available thru a NGINX reverse-proxy in this case, to expose the 443 port.

## Includes

- Create an AWS Elasticsearch Service instance (managed by AWS)
- Encryption with a KMS CMK (let you manage the usage of the KMS key)
- Accessible only from your public IP
- Under a custom VPC (`minimal-vpc` module) or default VPC (`minimal` module)

## Usage

### Input

| Name | Description | Type |  Default | Required |
|------|-------------|:------:|----------|:----------:|
| `my_public_ip` | Your public IP | String | | Yes |
| `aws_region` | The AWS region where you want to deploy your Elasticsearch instance | String | `us-east-1` | No |
| `domain_name` | Elasticsearch cluster name | String | `elasticsearch-single-node` | No |
| `elasticsearch_version` | Elasticsearch version | String | `6.3` | No |
| `instance_type` | Elasticsearch instance type (t2 family doesn't support encryption at rest) | String | `m4.large.elasticsearch` | No |
| `volume_size` | Elasticsearch volume size | String | `10` | No |
| `tags` | Default tags you want to add | Map | `Terraform=true` | No |

### Output

| Name | Description | Type |
|------|-------------|:------:|
| `elasticsearch_endpoint` | Elasticsearch public endpoint | String |
| `elasticsearch_kibana_endpoint` | Elasticsearch Kibana public endpoint | String |

### Examples

#### Under the default VPC

```bash
module "es-single-node" {
  source = "github.com/timoa/terraform-elasticsearch-single-node/minimal"

  # Your public IP to secure your Elasticsearch instance (required)
  my_public_ip    = "1.2.3.4"

  # AWS Region where you want to deploy your Elasticsearch single node
  aws_region      = "eu-west-2"

}
```

#### Under a new custom VPC

```bash
module "es-single-node" {
  source = "github.com/timoa/terraform-elasticsearch-single-node/minimal-vpc"

  # Your public IP to secure your Elasticsearch instance (required)
  my_public_ip    = "1.2.3.4"

  # AWS Region where you want to deploy your Elasticsearch single node
  aws_region      = "eu-west-2"

}
```

## Improvements

This Terraform module can also be improved by adding this changes:

- Support for multiple environments (distinct name and tags between environment)
- Support for Route 53 (by adding an alias to an existing Route 53 zone)

## References

### Security/Compliance

#### Cloud Conformity

| Description | Risk level | Link |
|-------------|:------------:|------|
| Elasticsearch Domain open to Internet | **High**| [Elasticsearch Domain IP-Based Access][1] |
| Elasticsearch Domain without encryption at rest | **High** | [Enable AWS ElasticSearch Encryption At Rest][2] |
| Elasticsearch Domain encryption with AWS managed-keys |  **High**  | [Elasticsearch Domain Encrypted with KMS CMKs][3] |
| Elasticsearch Domain outside custom VPC |  **High**  | [AWS Elasticsearch Domain In VPC][4]

[1]: https://www.cloudconformity.com/conformity-rules/Elasticsearch/elasticsearch-accessible-only-from-whitelisted-ip-addresses.html
[2]: https://www.cloudconformity.com/conformity-rules/Elasticsearch/encryption-at-rest.html
[3]: https://www.cloudconformity.com/conformity-rules/Elasticsearch/domain-encrypted-with-kms-customer-master-keys.html
[4]: https://www.cloudconformity.com/conformity-rules/Elasticsearch/domain-in-vpc.html
