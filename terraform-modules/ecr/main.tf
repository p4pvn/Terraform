resource "aws_ecr_repository" "repos" {
  for_each = var.microservices
  name     = each.value
}

