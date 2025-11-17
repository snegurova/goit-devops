output "vpc_id" {
  description = "ID of created VPC"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "ID list of public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnets" {
  description = "ID list of private subnets"
  value       = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  description = "ID Internet Gateway"
  value       = aws_internet_gateway.igw.id
}
