output "elasticsearch_kms_key_id" {
  description = "Elasticsearch KMS Key ID"
  value       = "${aws_kms_key.elasticsearch_kms_key.key_id}"
}
