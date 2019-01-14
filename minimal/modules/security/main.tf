resource "aws_kms_key" "elasticsearch_kms_key" {
  description = "KMS key used to encrypt the Elasticsearch volume"

  # Tags
  tags = "${merge(var.tags, map(
    "Name", "elasticsearch-kms"
  ))}"
}

resource "aws_kms_alias" "key" {
  name          = "alias/elasticsearch-kms"
  target_key_id = "${aws_kms_key.elasticsearch_kms_key.key_id}"
}
