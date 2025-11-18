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

output "eks_cluster_endpoint" {
  description = "EKS API endpoint for connecting to the cluster"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.eks_cluster_name
}

output "eks_node_role_arn" {
  description = "IAM role ARN for EKS Worker Nodes"
  value       = module.eks.eks_node_role_arn
}
