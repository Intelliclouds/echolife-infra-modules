##########################################
# DB Subnet Group
##########################################

resource "aws_db_subnet_group" "this" {
  name = "echolife-${var.environment}-db-subnet-group"

  subnet_ids = var.private_data_subnet_ids

  tags = {
    Name        = "echolife-${var.environment}-db-subnet-group"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
