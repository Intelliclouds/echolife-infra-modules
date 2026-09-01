##########################################
# Existing KMS Key
##########################################

data "aws_kms_alias" "s3" {
  name = var.kms_key_alias
}
