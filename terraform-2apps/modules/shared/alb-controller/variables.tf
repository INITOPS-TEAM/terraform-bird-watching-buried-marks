variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "oidc_provider_arn" {
  type        = string
  description = "OIDC provider ARN for the cluster"
}

variable "oidc_provider_url" {
  type        = string
  description = "OIDC provider URL (without https://)"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}
