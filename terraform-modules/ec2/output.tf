output "instance_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.this.id
}

output "instance_arn" {
  description = "The ARN of the EC2 instance."
  value       = aws_instance.this.arn
}

output "private_ip" {
  description = "The private IP address of the EC2 instance."
  value       = aws_instance.this.private_ip
}

output "public_ip" {
  description = "The public IP address of the EC2 instance (if associated)."
  value       = var.associate_public_ip_address ? aws_instance.this.public_ip : null
}

output "public_dns" {
  description = "The public DNS name of the EC2 instance (if associated)."
  value       = var.associate_public_ip_address ? aws_instance.this.public_dns : null
}

output "primary_network_interface_id" {
  description = "The ID of the primary network interface."
  value       = aws_instance.this.primary_network_interface_id
}

output "eip_id" {
  description = "The ID of the Elastic IP address (if associated)."
  value       = var.associate_public_ip_address ? aws_eip.this[0].id : null
}

output "eip_public_ip" {
  description = "The public IP address of the Elastic IP (if associated)."
  value       = var.associate_public_ip_address ? aws_eip.this[0].public_ip : null
}

output "log_group_name" {
  description = "The name of the CloudWatch Log Group."
  value       = aws_cloudwatch_log_group.instance_logs.name
}

output "log_group_arn" {
  description = "The ARN of the CloudWatch Log Group."
  value       = aws_cloudwatch_log_group.instance_logs.arn
}

output "ami_id_used" {
  description = "The actual AMI ID used for the EC2 instance (either provided or discovered)."
  value       = local.actual_ami_id
}
