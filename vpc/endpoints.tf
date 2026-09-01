# Fetch the current AWS region dynamically (e.g., ap-south-1)
data "aws_region" "current" {}

# ====================================================================
# 1. Endpoint Security Group
# ====================================================================
resource "aws_security_group" "vpc_endpoints" {
  name        = "echolife-${var.environment}-sg-endpoints"
  description = "Allow EKS nodes to communicate with AWS VPC Endpoints"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]


       
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "echolife-${var.environment}-sg-endpoints"
  }
}

# ====================================================================
# 2. S3 Gateway Endpoint (Free, highly critical for media uploads)
# ====================================================================
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"

  # Attach to App and Data route tables so they bypass the NAT Gateway for S3
  route_table_ids = concat(
    aws_route_table.private_app[*].id,
    [aws_route_table.private_data.id]
  )

  tags = { Name = "echolife-${var.environment}-vpce-s3" }
}

# ====================================================================
# 3. Interface Endpoints (For EKS dependencies)
# ====================================================================
locals {
  endpoints = {
    "ecr_api" = "ecr.api"
    "ecr_dkr" = "ecr.dkr"
    "secrets" = "secretsmanager"
    "logs"    = "logs"
    "sts"     = "sts"
  }
}

resource "aws_vpc_endpoint" "interfaces" {
  for_each = local.endpoints

  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.${each.value}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private_app[*].id
  security_group_ids  = [aws_security_group.vpc_endpoints.id]
  private_dns_enabled = true

  tags = { Name = "echolife-${var.environment}-vpce-${each.key}" }
}
