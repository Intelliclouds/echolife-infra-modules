##########################################
# RDS Security Group
##########################################

resource "aws_security_group" "rds" {
  name        = "echolife-${var.environment}-sg-rds"
  description = "Security group for PostgreSQL"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "echolife-${var.environment}-sg-rds"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
##########################################
# Allow PostgreSQL from EKS
##########################################

resource "aws_security_group_rule" "postgres_ingress" {
  count = length(var.vpc_security_group_ids)

  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"

  security_group_id        = aws_security_group.rds.id
  source_security_group_id = var.vpc_security_group_ids[count.index]
}
##########################################
# Outbound
##########################################

resource "aws_security_group_rule" "egress" {

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = aws_security_group.rds.id
}
