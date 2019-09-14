output "elasticsearch_endpoint" {
  description = "Public IP assigned to the Jenkins master"
  value       = module.elasticsearch.elasticsearch_endpoint
}