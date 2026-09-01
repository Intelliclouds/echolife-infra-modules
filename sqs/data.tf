##########################################
# Existing KMS Key
##########################################

data "aws_kms_alias" "sqs" {
  name = var.kms_key_alias
}
