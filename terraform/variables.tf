variable "aws_region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "eu-north-1"
}

variable "availability_zone" {
  description = "Availability zone for the public subnet."
  type        = string
  default     = "eu-north-1a"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
  default     = "10.0.0.0/20"
}

variable "security_group_name" {
  description = "Name of the security group."
  type        = string
  default     = "deepti-devops-security-group"
}

variable "security_group_description" {
  description = "Description for the security group."
  type        = string
  default     = "Allow SSH and HTTP"
}

variable "ami" {
  description = "AMI ID for the EC2 instance."
  type        = string
  default     = "ami-02461c8b8fe561859"
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t4g.micro"
}

variable "key_name" {
  description = "EC2 key pair name."
  type        = string
  default     = "deepti-aws-key"
}

variable "iam_instance_profile" {
  description = "IAM instance profile name for the EC2 instance."
  type        = string
  default     = "deepti-ec2-pull-image"
}

variable "user_data" {
  description = "User data script to run on instance boot."
  type        = string
  default     = <<-EOF
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

