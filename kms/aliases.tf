resource "aws_kms_alias" "eks" {
  name          = "alias/echolife-${var.environment}-eks"
  target_key_id = aws_kms_key.eks.key_id
}

resource "aws_kms_alias" "rds" {
  name          = "alias/echolife-${var.environment}-rds"
  target_key_id = aws_kms_key.rds.key_id
}

resource "aws_kms_alias" "secrets" {
  name          = "alias/echolife-${var.environment}-secrets"
  target_key_id = aws_kms_key.secrets.key_id
}
