// main.tf
locals {
  use_kms     = var.encryption_type == "aws:kms"
  kms_key_arn = local.use_kms ? coalesce(var.kms_key_arn, try(aws_kms_key.this[0].arn, null)) : null
}

resource "aws_kms_key" "this" {
  count                   = local.use_kms && var.create_kms_key ? 1 : 0
  description             = "KMS key for S3 bucket ${var.bucket_name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  tags                    = var.tags
}

resource "aws_kms_alias" "this" {
  count         = local.use_kms && var.create_kms_key ? 1 : 0
  name          = "alias/s3-${replace(var.bucket_name, ".", "-")}"
  target_key_id  = aws_kms_key.this[0].key_id
}

resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  tags          = var.tags
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.encryption_type
      kms_master_key_id  = local.kms_key_arn
    }

    bucket_key_enabled = local.use_kms
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "standard-lifecycle"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = var.abort_incomplete_multipart_upload_days
    }

    transition {
      days          = var.transition_to_ia_days
      storage_class  = "STANDARD_IA"
    }

    transition {
      days          = var.transition_to_glacier_days
      storage_class  = "GLACIER"
    }

    expiration {
      days = var.object_expiration_days
    }

    noncurrent_version_transition {
      noncurrent_days = var.noncurrent_version_transition_days
      storage_class   = "STANDARD_IA"
    }

    noncurrent_version_expiration {
      noncurrent_days = var.noncurrent_version_expiration_days
    }
  }
}
