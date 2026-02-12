output "vpc_id" {
  description = "VPC ID."
  value       = aws_vpc.dee-devops-vpc.id
}

output "public_subnet_id" {
  description = "Public subnet ID."
  value       = aws_subnet.dee-devops-public-subnet.id
}

 