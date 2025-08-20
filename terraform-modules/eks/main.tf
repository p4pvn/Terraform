resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster_name}-cluster-role"

  # The cluster will assume this role that is alreay created by aws readily.
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}


# Attach the EKS cluster policy to the role.
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# EKS worker nodes require an IAM role to join the cluster and interact with other AWS services.
resource "aws_iam_role" "eks_node_group_role" {
  name = "${var.cluster_name}-node-group-role"

  # The EC2 instances will assume this role.
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# Attach essential policies for the managed node group.
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group_role.name
}


# The core EKS cluster resource.
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  # The cluster is placed in private subnets for security.
  vpc_config {
    subnet_ids         = var.private_subnets
    endpoint_private_access = true
    endpoint_public_access  = false # Disable public access for enhanced security
  }

  # Control plane logging for troubleshooting and auditing.
  # This is a key best practice for production clusters.
  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]

  # The Kubernetes version for the cluster.
  version = "1.29"

  tags = {
    Name = var.cluster_name
  }
}


################################################################################
# EKS Managed Node Group
################################################################################

# The managed node group provides the EC2 instances that will run your workloads.
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = var.private_subnets
  instance_types  = [var.instance_type]

  # Node group scaling configuration.
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  # This setting ensures the node group is managed by AWS and auto-replaces unhealthy nodes.
  launch_template_configuration {
    name    = "eks-node-group-${var.cluster_name}"
    version = "$LATEST"
  }

  # Add a taint to the node group. This can be useful if you want to
  # prevent certain pods from being scheduled on these nodes by default.
  # This is a great example of a deeper configuration option.
  # taint {
  #   key    = "specialized"
  #   value  = "true"
  #   effect = "NO_SCHEDULE"
  # }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_worker_node_policy,
  ]
}
