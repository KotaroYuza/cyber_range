# VPC
resource "aws_vpc" "attacker_vpc" {
  count                = var.perform_attack ? 1 : 0
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.app_name}-${var.env_name}-attacker-vpc"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Subnet 1a
resource "aws_subnet" "attacker_ap_northeast_1a" {
  count                   = var.perform_attack ? 1 : 0
  vpc_id                  = aws_vpc.attacker_vpc[0].id
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
  cidr_block              = "172.16.3.0/24"
  tags = {
    Name = "${var.app_name}-${var.env_name}-attacker-subnet-1a"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Subnet 1c
resource "aws_subnet" "attacker_ap_northeast_1c" {
  count                   = var.perform_attack ? 1 : 0
  vpc_id                  = aws_vpc.attacker_vpc[0].id
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true
  cidr_block              = "172.16.2.0/24"
  tags = {
    Name = "${var.app_name}-${var.env_name}-attacker-subnet-1c"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Subnet 1d
resource "aws_subnet" "attacker_ap_northeast_1d" {
  count                   = var.perform_attack ? 1 : 0
  vpc_id                  = aws_vpc.attacker_vpc[0].id
  availability_zone       = "ap-northeast-1d"
  map_public_ip_on_launch = true
  cidr_block              = "172.16.1.0/24"
  tags = {
    Name = "${var.app_name}-${var.env_name}-attacker-subnet-1d"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Internet Gateway
resource "aws_internet_gateway" "attacker_internet_gateway" {
  count  = var.perform_attack ? 1 : 0
  vpc_id = aws_vpc.attacker_vpc[0].id
  tags = {
    Name = "${var.app_name}-${var.env_name}-attacker-igw"
  }
}

# Public Route Table
resource "aws_route_table" "attacker_route_table_public" {
  count  = var.perform_attack ? 1 : 0
  vpc_id = aws_vpc.attacker_vpc[0].id
  tags = {
    Name = "${var.app_name}-${var.env_name}-attacker-route-public"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.attacker_internet_gateway[0].id
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Private Route Table
resource "aws_route_table" "attacker_route_table_private" {
  count  = var.perform_attack ? 1 : 0
  vpc_id = aws_vpc.attacker_vpc[0].id
  tags = {
    Name = "${var.app_name}-${var.env_name}-attacker-route-private"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_route_table_association" "attacker_route_table_association_1a" {
  count          = var.perform_attack ? 1 : 0
  route_table_id = aws_route_table.attacker_route_table_public[0].id
  subnet_id      = aws_subnet.attacker_ap_northeast_1a[0].id
}
resource "aws_route_table_association" "attacker_route_table_association_1c" {
  count          = var.perform_attack ? 1 : 0
  route_table_id = aws_route_table.attacker_route_table_public[0].id
  subnet_id      = aws_subnet.attacker_ap_northeast_1c[0].id
}
resource "aws_route_table_association" "attacker_route_table_association_1d" {
  count          = var.perform_attack ? 1 : 0
  route_table_id = aws_route_table.attacker_route_table_public[0].id
  subnet_id      = aws_subnet.attacker_ap_northeast_1d[0].id
}

resource "aws_main_route_table_association" "attacker_main_route_table_association" {
  count          = var.perform_attack ? 1 : 0
  route_table_id = aws_route_table.attacker_route_table_public[0].id
  vpc_id         = aws_vpc.attacker_vpc[0].id
}
