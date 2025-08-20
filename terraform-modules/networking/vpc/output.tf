output "vpc_id" {
  description = "The ID of the created VPC."
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "The ID of the created public subnet."
  value       = aws_subnet.public.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the created VPC."
  value       = aws_vpc.main.cidr_block
}
