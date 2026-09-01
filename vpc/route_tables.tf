# --- Public Route Table (Routes to IGW) ---
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = { Name = "echolife-${var.environment}-rt-public" }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# --- Private App Route Tables (Routes to NAT) ---
# We need 1 Route Table per AZ so traffic stays in its local AZ's NAT Gateway.
resource "aws_route_table" "private_app" {
  count  = length(var.private_app_subnets)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }
  tags = { Name = "echolife-${var.environment}-rt-app-${var.azs[count.index]}" }
}

resource "aws_route_table_association" "private_app" {
  count          = length(var.private_app_subnets)
  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = aws_route_table.private_app[count.index].id
}

# --- Private Data Route Table (Isolated) ---
# Intentionally missing the 0.0.0.0/0 route so databases cannot reach the internet.
resource "aws_route_table" "private_data" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "echolife-${var.environment}-rt-data" }
}

resource "aws_route_table_association" "private_data" {
  count          = length(var.private_data_subnets)
  subnet_id      = aws_subnet.private_data[count.index].id
  route_table_id = aws_route_table.private_data.id
}
