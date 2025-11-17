output "vpc_id" {
  description = "ID of created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "ID list of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "ID list of private subnets"
  value       = module.vpc.private_subnets
}

output "internet_gateway_id" {
  description = "ID Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = module.ecr.repository_url
}
