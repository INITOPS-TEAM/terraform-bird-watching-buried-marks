variable "account_id" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "app2" {
  type = string
}

variable "public_key_path" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_type_jenkins" {
  type = string
}

variable "app_instance_count" {
  type = number
}

variable "domain_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "nat_az" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "public_subnets" {
  type = map(string)
}

variable "compute_subnets" {
  type = map(string)
}

variable "eks_subnets" {
  type = map(string)
}

variable "namespace" {
  type = string
}

variable "ver_eso" {
  type = string
}

variable "db_instance_class" {
  type = string
}
