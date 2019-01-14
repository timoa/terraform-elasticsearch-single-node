output "elasticsearch_endpoint" {
  value = "${aws_elasticsearch_domain.elasticsearch.endpoint}"
}

output "elasticsearch_arn" {
  value = "${aws_elasticsearch_domain.elasticsearch.arn}"
}

output "elasticsearch_domain_id" {
  value = "${aws_elasticsearch_domain.elasticsearch.domain_id}"
}

output "elasticsearch_kibana_endpoint" {
  value = "${aws_elasticsearch_domain.elasticsearch.kibana_endpoint}"
}
