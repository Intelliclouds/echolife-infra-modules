# ====================================================================
# 1. Core S3 Bucket
# ====================================================================
resource "aws_s3_bucket" "media" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

# ====================================================================
# 2. Block Public Access (Security Requirement)
# ====================================================================
resource "aws_s3_bucket_public_access_block" "media_block" {
  bucket = aws_s3_bucket.media.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ====================================================================
# 3. Data Encryption at Rest
# ====================================================================
resource "aws_s3_bucket_server_side_encryption_configuration" "media_encryption" {
  bucket = aws_s3_bucket.media.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256" # Use aws:kms if you have a custom KMS key
    }
  }
}
