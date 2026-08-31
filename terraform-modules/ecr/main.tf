provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "repos" {
  for_each = var.microservices

  name                 = each.value
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name        = each.value
    Environment = "var.environment"
    ManagedBy   = "terraform"
    Project     = "terraform"
    Team        = "p4pvn"
  }
}

resource "aws_ecr_lifecycle_policy" "lifecycle" {
  for_each = var.microservices

  repository = aws_ecr_repository.repos[each.key].name
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep only the last 10 images"
        selection = {
          tagStatus     = "any"
          countType     = "imageCountMoreThan"
          countNumber   = 10
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Delete images older than 3 months"
        selection = {
          tagStatus     = "any"
          countType     = "sinceImagePushed"
          countUnit     = "days"
          countNumber   = 90
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
