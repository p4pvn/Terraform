variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "microservices-eks-cluster"
}

variable "region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The ID of the VPC to deploy the EKS cluster into."
  type        = string
}

variable "private_subnets" {
  description = "A list of private subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnet IDs for the EKS cluster, primarily for load balancers."
  type        = list(string)
}

variable "instance_type" {
  description = "The instance type for the EKS worker nodes."
  type        = string
  default     = "t3.medium"
}

variable "desired_size" {
  description = "The desired number of worker nodes in the managed node group."
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum number of worker nodes."
  type        = number
  default     = 5
}

variable "min_size" {
  description = "The minimum number of worker nodes."
  type        = number
  default     = 2
}
