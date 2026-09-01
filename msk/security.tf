##########################################
# MSK Security Group
##########################################

resource "aws_security_group" "msk" {

  name        = "echolife-${var.environment}-sg-msk"
  description = "Security Group for MSK Cluster"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "echolife-${var.environment}-sg-msk"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

##########################################
# Allow Kafka from EKS
##########################################

resource "aws_security_group_rule" "ingress" {

  count = length(var.vpc_security_group_ids)

  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 9092
  to_port                  = 9098

  security_group_id        = aws_security_group.msk.id
 
