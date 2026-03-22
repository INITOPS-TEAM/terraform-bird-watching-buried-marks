variable "env" {
  type        = string
  description = "The environment name (dev, stage, prod)"
}

variable "domain_name" {
  type = string
  description = "The domain for LB"
}

variable "lb_ip" {
  description = "Public IP of the EC2 Load Balancer"
  type        = string
}
