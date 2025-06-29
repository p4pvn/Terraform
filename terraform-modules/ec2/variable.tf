variable "name_prefix" {
  description = "A prefix for naming resources to ensure uniqueness and identification."
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch."
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance in."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with the instance."
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access to the instance."
  type        = string
  default     = ""
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance."
  type        = bool
  default     = false
}

variable "enable_monitoring" {
  description = "Whether to enable detailed CloudWatch monitoring for the instance."
  type        = bool
  default     = true
}

variable "user_data" {
  description = "The user data to supply when launching the instance. This can be a shell script or cloud-init directives."
  type        = string
  default     = null
}

variable "iam_instance_profile_arn" {
  description = "The ARN of the IAM instance profile to associate with the instance."
  type        = string
  default     = null
}

variable "ami_id" {
  description = "The ID of the AMI to use for the instance. If null, the latest Amazon Linux 2 AMI will be used."
  type        = string
  default     = null
}

variable "root_block_device_volume_size" {
  description = "The size of the root block device in GiB."
  type        = number
  default     = 8 # Default for Amazon Linux 2
}

variable "root_block_device_volume_type" {
  description = "The type of the root block device (e.g., 'gp2', 'gp3', 'io1', 'standard')."
  type        = string
  default     = "gp2"
}

variable "root_block_device_encrypted" {
  description = "Whether the root block device should be encrypted."
  type        = bool
  default     = true # Best practice for security
}

variable "root_block_device_kms_key_id" {
  description = "The ARN of the KMS key to use for root block device encryption. Only applicable if `root_block_device_encrypted` is true."
  type        = string
  default     = null # Use AWS managed key if not specified
}

variable "log_retention_in_days" {
  description = "The number of days to retain CloudWatch Logs for the instance."
  type        = number
  default     = 30
}

variable "tags" {
  description = "A map of tags to apply to all resources created by this module."
  type        = map(string)
  default     = {}
}
