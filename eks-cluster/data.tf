##########################################
# AWS Caller Identity
##########################################

data "aws_caller_identity" "current" {}

##########################################
# AWS Region
##########################################

data "aws_region" "current" {}

##########################################
# KMS Key
##########################################

data "aws_kms_alias" "eks" {

  name = "alias/${var.project_name}-${var.environment}-eks"

}
