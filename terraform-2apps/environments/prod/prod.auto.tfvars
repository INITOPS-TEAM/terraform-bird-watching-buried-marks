env                   = "prod"
aws_region            = "eu-north-1"
project_name          = "bird"
app2                  = "buried-marks"
ami_id                = "ami-080254318c2d8932f"
instance_type         = "t3.micro"
instance_type_jenkins = "t3.small"
app_instance_count    = 2
public_key_path       = "~/.ssh/pictap-dev-ssh.pub"
domain_name           = "birds.pp.ua"
namespace             = "buried-marks"
account_id            = "833822972731"

#vpc
vpc_cidr     = "10.20.0.0/16"
cluster_name = "birdmarks-eks-prod"
nat_az       = "eu-north-1a"
public_subnets = {
  "eu-north-1a" = "10.20.1.0/24"
  "eu-north-1b" = "10.20.2.0/24"
}
compute_subnets = {
  "eu-north-1a" = "10.20.10.0/24"
  "eu-north-1b" = "10.20.20.0/24"
}
eks_subnets = {
  "eu-north-1a" = "10.20.128.0/20"
  "eu-north-1b" = "10.20.144.0/20"
}

ver_eso = "2.2.0"

db_instance_class = "db.t3.micro"
