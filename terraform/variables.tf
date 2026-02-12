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
  default     = "dee-devops-security-group"
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
