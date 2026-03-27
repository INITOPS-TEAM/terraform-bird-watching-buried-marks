terraform {
  required_version = ">= 1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }

  registries = [
    {
      url      = local.repository
      username = var.ecr_username
      password = var.ecr_password
    }
  ]
}
