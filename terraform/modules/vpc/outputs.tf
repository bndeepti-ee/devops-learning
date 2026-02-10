output "vpc_id" {
  description = "VPC ID."
  value       = aws_vpc.deepti-devops-vpc.id
}

output "public_subnet_id" {
  description = "Public subnet ID."
  value       = aws_subnet.deepti-devops-public-subnet.id
}

 