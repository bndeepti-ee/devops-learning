variable "ami" {
  description = "AMI ID."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs."
  type        = list(string)
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP."
  type        = bool
  default     = true
}

variable "key_name" {
  description = "EC2 key pair name."
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile name."
  type        = string
}

variable "user_data" {
  description = "User data script."
  type        = string
  default     = null
}

