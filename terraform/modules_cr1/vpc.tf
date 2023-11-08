# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.app_name}-${var.env_name}-vpc"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Subnet 1a
resource "aws_subnet" "ap_northeast_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
  cidr_block              = "172.16.3.0/24"
  tags = {
    Name = "${var.app_name}-${var.env_name}-subnet-1a"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Subnet 1c
resource "aws_subnet" "ap_northeast_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true
  cidr_block              = "172.16.2.0/24"
  tags = {
    Name = "${var.app_name}-${var.env_name}-subnet-1c"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Subnet 1d
resource "aws_subnet" "ap_northeast_1d" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1d"
  map_public_ip_on_launch = true
  cidr_block              = "172.16.1.0/24"
  tags = {
    Name = "${var.app_name}-${var.env_name}-subnet-1d"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.app_name}-${var.env_name}-igw"
  }
}

# Public Route Table
resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.app_name}-${var.env_name}-route-public"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Private Route Table
resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.app_name}-${var.env_name}-route-private"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_route_table_association" "route_table_association_1a" {
  route_table_id = aws_route_table.route_table_public.id
  subnet_id      = aws_subnet.ap_northeast_1a.id
}
resource "aws_route_table_association" "route_table_association_1c" {
  route_table_id = aws_route_table.route_table_public.id
  subnet_id      = aws_subnet.ap_northeast_1c.id
}
resource "aws_route_table_association" "route_table_association_1d" {
  route_table_id = aws_route_table.route_table_public.id
  subnet_id      = aws_subnet.ap_northeast_1d.id
}

resource "aws_main_route_table_association" "main_route_table_association" {
  route_table_id = aws_route_table.route_table_public.id
  vpc_id         = aws_vpc.vpc.id
}
