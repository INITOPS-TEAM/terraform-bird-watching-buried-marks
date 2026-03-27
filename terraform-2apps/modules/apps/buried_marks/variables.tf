variable "project_name" {
    type = string
}

variable "app2" {
    type = string
}

variable "vpc_id" {
    type        = string
    description = "VPC ID"
}


variable "env" {
    type = string
}

variable "ver_eso" {
    type = string
}

variable "aws_region" {
    type = string
}

variable "eks_nodes_sg_id" {
    type        = string
    description = "ID of the EKS nodes security group"
}

variable "db_instance_class" {
    type        = string
    description = "RDS instance class"
}

variable "compute_subnet_ids" {
    type = list(string)
}