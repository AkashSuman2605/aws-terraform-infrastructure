# Main VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true

  tags = {
    Name = "prod-vpc"
  }
}

# Public Subnet - AZ A
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-a"
  }
}

# Public Subnet - AZ B
resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-b"
  }
}

# Private Subnet - AZ A
resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_a_cidr
  availability_zone = var.az_a

  tags = {
    Name = "private-subnet-a"
  }
}

# Private Subnet - AZ B
resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_b_cidr
  availability_zone = var.az_b

  tags = {
    Name = "private-subnet-b"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id

  # NAT Gateway must be in public subnet
  subnet_id = aws_subnet.public_subnet_a.id

  tags = {
    Name = "main-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

# Associate Public Subnet A
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

# Associate Public Subnet B
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}

# Associate Private Subnet A
resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_rt.id
}

# Associate Private Subnet B
resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_rt.id
}
