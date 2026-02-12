resource "aws_vpc" "dee-devops-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "dee-devops-internet-gateway" {
  vpc_id = aws_vpc.dee-devops-vpc.id
}

resource "aws_route_table" "dee-devops-route-table" {
  vpc_id = aws_vpc.dee-devops-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dee-devops-internet-gateway.id
  }
}

resource "aws_subnet" "dee-devops-public-subnet" {
  vpc_id                  = aws_vpc.dee-devops-vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone
}

resource "aws_route_table_association" "dee-devops-route-table-association" {
  subnet_id      = aws_subnet.dee-devops-public-subnet.id
  route_table_id = aws_route_table.dee-devops-route-table.id
}

