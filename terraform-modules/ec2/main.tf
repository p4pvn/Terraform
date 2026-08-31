data "aws_ami" "amazon_linux_2" {
  count = var.ami_id == null ? 1 : 0 # Only fetch if ami_id is not provided
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  actual_ami_id = var.ami_id != null ? var.ami_id : (
    length(data.aws_ami.amazon_linux_2) > 0 ? data.aws_ami.amazon_linux_2[0].id : null
  )
}

resource "aws_instance" "this" {
  ami                         = local.actual_ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  monitoring                  = var.enable_monitoring
  user_data                   = var.user_data
  iam_instance_profile        = var.iam_instance_profile_arn #replace this w data block later

  root_block_device {
    volume_size           = var.root_block_device_volume_size
    volume_type           = var.root_block_device_volume_type
    encrypted             = var.root_block_device_encrypted
    kms_key_id            = var.root_block_device_kms_key_id
    delete_on_termination = true
  }

  tags = merge(
    {
      Name = var.name_prefix
    },
    var.tags # Merge any additional tags provided by the caller
  )

  lifecycle {
    create_before_destroy = true
    # prevent_destroy     = true
  }
}

resource "aws_cloudwatch_log_group" "instance_logs" {
  name              = "/aws/ec2/${var.name_prefix}"
  retention_in_days = 30 # Adjust as per your logging retention policy

  tags = merge(
    {
      Name = "${var.name_prefix}-logs"
    },
    var.tags
  )
}

resource "aws_eip" "this" {
  count    = var.associate_public_ip_address ? 1 : 0
  vpc      = true
  instance = aws_instance.this.id # Associate with the EC2 instance

  tags = merge(
    {
      Name = "${var.name_prefix}-eip"
    },
    var.tags
  )
}
