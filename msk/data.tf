##########################################
# Existing KMS Key
##########################################

data "aws_kms_alias" "msk" {
  name = var.kms_key_alias
}
