output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.name
}

output "node_group_role_arn" {
  description = "The ARN of the IAM role for the EKS node group."
  value       = aws_iam_role.eks_node_group_role.arn
}

output "kubeconfig_command" {
  description = "Command to configure kubectl to connect to the EKS cluster."
  value       = "aws eks update-kubeconfig --region ${var.region} --name ${var.cluster_name}"
}
