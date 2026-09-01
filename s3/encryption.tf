##########################################
# Server Side Encryption
##########################################

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {

  bucket = aws_s3_bucket.this.id

  rule {

    apply_server_side_encryption_by_default {

      kms_master_key_id = data.aws_kms_alias.s3.target_key_arn

      sse_algorithm = "aws:kms"
    }

    bucket_key_enabled = true
  }
}
