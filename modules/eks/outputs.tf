output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_version" {
  description = "The version of the EKS cluster"
  value       = aws_eks_cluster.this.version
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = var.eks_name
}