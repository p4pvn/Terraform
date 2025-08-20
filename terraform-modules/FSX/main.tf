provider "aws" {
  region = "us-east-1"
}

# Call the VPC module to create the VPC and subnet.
module "network" {
  source = "../terraform-modules/networking/vpc/module"
}

# Security Group for the FSx File System
resource "aws_security_group" "fsx_sg" {
  name        = "fsx-lustre-sg"
  description = "Allows inbound access to FSx for Lustre"
  vpc_id      = module.network.vpc_id

  # Inbound rule for Lustre traffic.
  ingress {
    from_port   = 988
    to_port     = 988
    protocol    = "tcp"
    cidr_blocks = [module.network.vpc_cidr_block]
  }

  # All outbound traffic is allowed.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fsx-lustre-security-group"
  }
}

resource "aws_fsx_lustre_file_system" "main" {
  deployment_type = var.deployment_type
  storage_capacity_gb = var.storage_capacity_gb
  throughput_capacity_per_gib = var.throughput_capacity_per_gib
  subnet_ids = [module.network.subnet_id]
  security_group_ids = [aws_security_group.fsx_sg.id]

  tags = {
    Name = "MyFSXLustreFileSystem"
  }
}
