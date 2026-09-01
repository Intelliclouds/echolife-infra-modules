##########################################
# Application S3 Bucket
##########################################

resource "aws_s3_bucket" "this" {

  bucket = var.bucket_name

  force_destroy = false

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
