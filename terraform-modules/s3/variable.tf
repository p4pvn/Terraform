
// variables.tf
variable "bucket_name" {
  description = "Globally unique S3 bucket name."
  type        = string
}

variable "force_destroy" {
  description = "Allow Terraform to delete non-empty bucket."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}

variable "versioning_enabled" {
  description = "Enable S3 bucket versioning."
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "S3 encryption type. Use aws:kms or AES256."
  type        = string
  default     = "aws:kms"

  validation {
    condition     = contains(["aws:kms", "AES256"], var.encryption_type)
    error_message = "encryption_type must be either aws:kms or AES256."
  }
}

variable "create_kms_key" {
  description = "Create a dedicated KMS key when encryption_type is aws:kms."
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "Existing KMS key ARN to use. If null and create_kms_key=true, a new key is created."
  type        = string
  default     = null
}

variable "transition_to_ia_days" {
  description = "Days after which objects transition to STANDARD_IA."
  type        = number
  default     = 30
}

variable "transition_to_glacier_days" {
  description = "Days after which objects transition to GLACIER."
  type        = number
  default     = 90
}

variable "object_expiration_days" {
  description = "Days after which current objects expire."
  type        = number
  default     = 365
}

variable "noncurrent_version_transition_days" {
  description = "Days after which noncurrent versions transition to STANDARD_IA."
  type        = number
  default     = 30
}

variable "noncurrent_version_expiration_days" {
  description = "Days after which noncurrent versions expire."
  type        = number
  default     = 90
}

variable "abort_incomplete_multipart_upload_days" {
  description = "Days after which incomplete multipart uploads are aborted."
  type        = number
  default     = 7
}
