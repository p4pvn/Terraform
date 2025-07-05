provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "repos" {
  for_each = var.microservices
  name     = each.value
}

