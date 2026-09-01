##########################################
# Outputs
##########################################

output "bucket_id" {
  description = "Bucket ID"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "Bucket ARN"
  value       = aws_s3_bucket.this.arn
}

output "bucket_name" {
  description = "Bucket Name"
  value       = aws_s3_bucket.this.bucket
}

output "bucket_domain_name" {
  description = "Bucket Domain Name"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "regional_domain_name" {
  description = "Regional Domain Name"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}
