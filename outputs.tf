output "vpc_id" {
  description = "The ID of the VPC"
  value       = var.enable_vpc && length(module.vpc) > 0 ? module.vpc[0].vpc_id : null
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = var.enable_eks && length(module.eks) > 0 ? module.eks[0].cluster_endpoint : null
}

output "eks_cluster_version" {
  description = "The version of the EKS cluster"
  value       = var.enable_eks && length(module.eks) > 0 ? module.eks[0].cluster_version : null
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = var.cluster_name
}
