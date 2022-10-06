# VPC Definition
resource "aws_vpc" "ec2_demo_vpc" {
  cidr_block       = "10.48.0.0/16"
  instance_tenancy = "default"

  tags = { Name = "${var.name_prefix}-vpc" }
}

# Public Subnet
resource "aws_subnet" "demo_public" {
  vpc_id            = aws_vpc.ec2_demo_vpc.id
  cidr_block        = "10.48.10.0/24"
  availability_zone = "${var.aws_region}a"
  tags              = { Name = "${var.name_prefix}-public" }
}

# Private Subnet
resource "aws_subnet" "demo_private" {
  vpc_id            = aws_vpc.ec2_demo_vpc.id
  cidr_block        = "10.48.20.0/24"
  availability_zone = "${var.aws_region}a"
  tags              = { Name = "${var.name_prefix}-private" }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.ec2_demo_vpc.id
  tags   = { Name = "${var.name_prefix}-gw" }
}

# EIP for NAT Gateway
resource "aws_eip" "nat_gateway" {
  vpc = true
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.demo_public.id

  tags = { Name = "${var.name_prefix}-ngw" }
}

# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.ec2_demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = { Name = "${var.name_prefix}-public-rt" }
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.ec2_demo_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = { Name = "${var.name_prefix}-private-rt" }
}

# Public Subnets Association
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.demo_public.id
  route_table_id = aws_route_table.public_route_table.id
}

# Private Subnets Association
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.demo_private.id
  route_table_id = aws_route_table.private_route_table.id
}