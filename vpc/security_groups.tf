# ====================================================================
# 1. Edge Tier: Application Load Balancer (Public)
# ====================================================================
resource "aws_security_group" "alb_public" {
  name        = "echolife-${var.environment}-sg-alb"
  description = "Public access to Kong API Gateway via ALB"
  vpc_id      = aws_vpc.main.id

  # Inbound HTTP/HTTPS from the internet (or WAF)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = { Name = "echolife-${var.environment}-sg-alb" }
}

# ====================================================================
# 2. Compute Tier: EKS Worker Nodes
# ====================================================================
resource "aws_security_group" "eks_nodes" {
  name        = "echolife-${var.environment}-sg-eks-nodes"
  description = "Security group for all EKS worker nodes"
  vpc_id      = aws_vpc.main.id

  # Inbound Pod-to-Pod communication (Self-referencing)
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  # UPDATED: Allow all outbound traffic so nodes can resolve DNS, 
  # reach the EKS API, and pull container images from ECR.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "echolife-${var.environment}-sg-eks-nodes" }
}

# ====================================================================
# 2.5 Break the Cycle: Standalone Cross-Referencing Rules
# ====================================================================

# Rule: Allow ALB to send traffic OUT to EKS nodes
resource "aws_security_group_rule" "alb_to_eks_egress" {
  type                     = "egress"
  from_port                = 8000
  to_port                  = 8443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_public.id
  source_security_group_id = aws_security_group.eks_nodes.id
}

# Rule: Allow EKS nodes to receive traffic IN from ALB
resource "aws_security_group_rule" "eks_from_alb_ingress" {
  type                     = "ingress"
  from_port                = 8000
  to_port                  = 8443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_nodes.id
  source_security_group_id = aws_security_group.alb_public.id
}
