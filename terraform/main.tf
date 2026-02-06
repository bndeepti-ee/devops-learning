terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.31.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

# --------------------
# VPC
# --------------------
resource "aws_vpc" "deepti-devops-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# --------------------
# Internet Gateway
# --------------------
resource "aws_internet_gateway" "deepti-devops-internet-gateway" {
  vpc_id = aws_vpc.deepti-devops-vpc.id
}

# --------------------
# Route Table
# --------------------
resource "aws_route_table" "deepti-devops-route-table" {
  vpc_id = aws_vpc.deepti-devops-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.deepti-devops-internet-gateway.id
  }
}

# --------------------
# Public Subnet
# --------------------
resource "aws_subnet" "deepti-devops-public-subnet" {
  vpc_id                  = aws_vpc.deepti-devops-vpc.id
  cidr_block              = "10.0.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "eu-north-1a"
}


resource "aws_route_table_association" "deepti-devops-route-table-association" {
  subnet_id      = aws_subnet.deepti-devops-public-subnet.id
  route_table_id = aws_route_table.deepti-devops-route-table.id
}

# --------------------
# Security Group
# --------------------
resource "aws_security_group" "deepti-devops-security-group" {
  name        = "deepti-devops-security-group"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.deepti-devops-vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --------------------
# EC2 Instance
# --------------------
resource "aws_instance" "deepti-devops-ec2" {
  ami                         = "ami-02461c8b8fe561859"
  instance_type               = "t4g.micro"
  subnet_id                   = aws_subnet.deepti-devops-public-subnet.id
  vpc_security_group_ids      = [aws_security_group.deepti-devops-security-group.id]
  associate_public_ip_address = true
  key_name                    = "deepti-aws-key"
  iam_instance_profile        = "deepti-ec2-pull-image"

  user_data = <<-EOF
#!/bin/bash

# Update system packages
sudo dnf update -y

# Install Docker
sudo dnf install -y docker
sudo systemctl start docker
sudo systemctl enable docker

# Allow ec2-user to run docker
sudo usermod -aG docker ec2-user

# Login to ECR (region MUST match)
aws ecr get-login-password --region eu-north-1 \
  | docker login --username AWS --password-stdin 889772146711.dkr.ecr.eu-north-1.amazonaws.com

# Pull image
docker pull 889772146711.dkr.ecr.eu-north-1.amazonaws.com/deepti:aws-devops-learning

# Run container
docker run -d -p 8000:8000 889772146711.dkr.ecr.eu-north-1.amazonaws.com/deepti:aws-devops-learning
EOF

}
