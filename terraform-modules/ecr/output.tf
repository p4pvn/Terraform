output "ecr_repository_names" {
  value = [for repo in aws_ecr_repository.repos : repo.name]
  description = "Names of all created ECR repositories"
}

output "ecr_repository_urls" {
  value = [for repo in aws_ecr_repository.repos : repo.repository_url]
  description = "Repository URIs for Docker push/pull"
}

output "ecr_lifecycle_policies" {
  value = {
    for key, policy in aws_ecr_lifecycle_policy.lifecycle :
    key => policy.repository
  }
  description = "Lifecycle policies attached to ECR repositories"
}
