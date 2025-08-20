output "fsx_file_system_id" {
  description = "The ID of the FSx for Lustre file system."
  value       = aws_fsx_lustre_file_system.main.id
}

output "fsx_dns_name" {
  description = "The DNS name for the FSx for Lustre file system."
  value       = aws_fsx_lustre_file_system.main.dns_name
}

# This output provides the mount name for the FSx file system.
output "fsx_mount_name" {
  description = "The mount name for the FSx for Lustre file system."
  value       = aws_fsx_lustre_file_system.main.mount_name
}

# These values are being passed through from the vpc module's outputs.

output "vpc_id" {
  description = "The ID of the VPC used for the FSx file system."
  value       = module.network.vpc_id
}

output "subnet_id" {
  description = "The ID of the subnet used for the FSx file system."
  value       = module.network.subnet_id
}
