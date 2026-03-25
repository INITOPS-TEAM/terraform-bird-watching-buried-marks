env                   = "dev"
aws_region            = "eu-north-1"
project_name          = "bird-secret-marks"
ami_id                = "ami-080254318c2d8932f"
instance_type         = "t3.micro"
instance_type_jenkins = "t3.small"
app_instance_count    = 2
public_key_path       = "~/.ssh/pictap-dev-ssh.pub"
domain_name           = "birds.pp.ua"

#vpc
vpc_cidr     = "10.0.0.0/16"
cluster_name = "birdmarks-eks-dev"
nat_az       = "eu-north-1a"
public_subnets = {
  "eu-north-1a" = "10.0.1.0/24"
  "eu-north-1b" = "10.0.2.0/24"
}
compute_subnets = {
  "eu-north-1a" = "10.0.10.0/24"
  "eu-north-1b" = "10.0.20.0/24"
}
eks_subnets = {
  "eu-north-1a" = "10.0.128.0/20"
  "eu-north-1b" = "10.0.144.0/20"
}
