output "region" {
  description = "AWS region"
  value       = var.aws-region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = var.eks_cluster_name
}