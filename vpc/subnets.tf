# -------------------------------------------------------------
# Public Edge Subnets (Load Balancers & NAT)
# -------------------------------------------------------------
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name                     = "echolife-${var.environment}-public-${var.azs[count.index]}"
    Tier                     = "Public"
    "kubernetes.io/role/elb" = "1" # Required for public EKS ALBs
    "kubernetes.io/cluster/echolife-eks" = "shared"
  }
}

# -------------------------------------------------------------
# Private Application Subnets (EKS Worker Nodes & Pods)
# -------------------------------------------------------------
resource "aws_subnet" "private_app" {
  count             = length(var.private_app_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_app_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name                              = "echolife-${var.environment}-app-${var.azs[count.index]}"
    Tier                              = "PrivateApp"
    "kubernetes.io/role/internal-elb" = "1" # Required for internal EKS ALBs
    "kubernetes.io/cluster/echolife-eks" = "shared"
  }
}

# -------------------------------------------------------------
# Private Data Subnets (RDS, Redis, MSK)
# -------------------------------------------------------------
resource "aws_subnet" "private_data" {
  count             = length(var.private_data_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_data_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "echolife-${var.environment}-data-${var.azs[count.index]}"
    Tier = "PrivateData"
  }
}
