output "elasticsearch_endpoint" {
  description = "Elasticsearch public endpoint"
  value       = "${module.elasticsearch.elasticsearch_endpoint}"
}

output "elasticsearch_kibana_endpoint" {
  description = "Elasticsearch Kibana public endpoint"
  value       = "${module.elasticsearch.elasticsearch_kibana_endpoint}"
}
