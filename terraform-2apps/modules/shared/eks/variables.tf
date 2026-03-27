variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "eks_subnets" {
  type        = list(string)
  description = "List of subnet IDs for EKS control plane"
}

variable "node_subnets" {
  type        = list(string)
  description = "List of subnet IDs for worker nodes"
}

variable "node_group_name" {
  type        = string
  default     = "primary"
  description = "Node group name"
}

variable "desired_size" {
  type        = number
  default     = 2
  description = "Desired number of nodes"
}

variable "min_size" {
  type        = number
  default     = 1
  description = "Minimum nodes"
}

variable "max_size" {
  type        = number
  default     = 3
  description = "Maximum nodes"
}

variable "instance_types" {
  type        = list(string)
  default     = ["t3.small"]
  description = "EC2 instance types"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.35"
  description = "Kubernetes version"
}

variable "aws_region" {
  type = string
}

variable "account_id" {
  type = string
}

variable "namespace" {
  type = string
}

variable "ecr_username" {
  type = string
}

variable "ecr_password" {
  type = string
}
