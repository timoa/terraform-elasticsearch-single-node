output "elasticsearch_endpoint" {
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
  value       = "${aws_elasticsearch_domain.elasticsearch.endpoint}"
}

output "elasticsearch_arn" {
  description = "Amazon Resource Name (ARN) of the domain"
  value       = "${aws_elasticsearch_domain.elasticsearch.arn}"
}

output "elasticsearch_domain_id" {
  description = "Unique identifier for the domain"
  value       = "${aws_elasticsearch_domain.elasticsearch.domain_id}"
}

output "elasticsearch_kibana_endpoint" {
  description = "Domain-specific endpoint for kibana without https scheme"
  value       = "${aws_elasticsearch_domain.elasticsearch.kibana_endpoint}"
}
