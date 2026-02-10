resource "aws_vpc" "deepti-devops-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "deepti-devops-internet-gateway" {
  vpc_id = aws_vpc.deepti-devops-vpc.id
}

resource "aws_route_table" "deepti-devops-route-table" {
  vpc_id = aws_vpc.deepti-devops-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.deepti-devops-internet-gateway.id
  }
}

resource "aws_subnet" "deepti-devops-public-subnet" {
  vpc_id                  = aws_vpc.deepti-devops-vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone
}

resource "aws_route_table_association" "deepti-devops-route-table-association" {
  subnet_id      = aws_subnet.deepti-devops-public-subnet.id
  route_table_id = aws_route_table.deepti-devops-route-table.id
}

