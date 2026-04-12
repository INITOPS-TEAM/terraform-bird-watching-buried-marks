resource "aws_key_pair" "this" {
  key_name   = "${var.project_name}-${var.env}-key"
  public_key = file(var.public_key_path)
}

module "vpc" {
  source = "../../modules/shared/vpc"

  project_name    = var.project_name
  env             = var.env
  aws_region      = var.aws_region
  vpc_cidr        = var.vpc_cidr
  nat_az          = var.nat_az
  cluster_name    = var.cluster_name
  public_subnets  = var.public_subnets
  compute_subnets = var.compute_subnets
  eks_subnets     = var.eks_subnets
}

module "eks" {
  source = "../../modules/shared/eks"

  cluster_name         = var.cluster_name
  vpc_id               = module.vpc.vpc_id
  eks_subnets          = module.vpc.eks_subnet_ids
  node_subnets         = module.vpc.compute_subnet_ids
  aws_region           = var.aws_region
  account_id           = var.account_id
  namespace            = var.namespace
  ecr_username         = data.aws_ecr_authorization_token.token.user_name
  ecr_password         = data.aws_ecr_authorization_token.token.password
  env                  = var.env
  app2                 = var.app2
  ver_eso              = var.ver_eso
  host_postgres_rds    = module.buried_marks.host_postgres_rds
  host_mariadb_rds     = module.buried_marks.host_mariadb_rds
  rds_auth_resource_id = module.buried_marks.rds_auth_resource_id
  rds_map_resource_id  = module.buried_marks.rds_map_resource_id

  desired_size   = 4
  min_size       = 2
  max_size       = 5
  instance_types = ["t3.small"]

  zone_id     = module.dns.zone_id
  domain_name = var.domain_name

  jenkins_role_arn = module.jenkins.jenkins_role_arn

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }
}

module "iam" {
  source = "../../modules/shared/IAM"

  project_name = var.project_name
  env          = var.env
}

# module "jenkins" {
#   source = "../../modules/shared/Jenkins"

#   project_name          = var.project_name
#   env                   = var.env
#   ami_id                = var.ami_id
#   instance_type_jenkins = var.instance_type_jenkins
#   consul_sg_id          = module.birdwatching.consul_sg_id
#   nat_az                = var.nat_az
#   key_name              = aws_key_pair.this.key_name
#   vpc_id                = module.vpc.vpc_id
#   vpc_cidr              = module.vpc.vpc_cidr
#   compute_subnet_id     = module.vpc.compute_subnet_id
# }

module "dns" {
  source = "../../modules/shared/dns"

  domain_name = var.domain_name
}

# module "birdwatching" {
#   source = "../../modules/apps/birdwatching"

#   project_name       = var.project_name
#   env                = var.env
#   ami_id             = var.ami_id
#   instance_type      = var.instance_type
#   key_name           = aws_key_pair.this.key_name
#   app_instance_count = var.app_instance_count
#   domain_name        = var.domain_name
#   zone_id            = module.dns.zone_id
#   vpc_id             = module.vpc.vpc_id
#   vpc_cidr           = module.vpc.vpc_cidr
#   compute_subnet_id  = module.vpc.compute_subnet_id
#   public_subnet_id   = module.vpc.public_subnet_id

#   jenkins_sg_id             = module.jenkins.jenkins_sg_id
#   app_role_name             = module.iam.app_role_name
#   iam_instance_profile_name = module.iam.app_instance_profile_name
#   ssm_instance_profile_name = module.iam.ssm_instance_profile_name
# }

module "buried_marks" {
  source             = "../../modules/apps/buried_marks"
  project_name       = var.project_name
  app2               = var.app2
  ver_eso            = var.ver_eso
  vpc_id             = module.vpc.vpc_id
  env                = var.env
  aws_region         = var.aws_region
  db_instance_class  = var.db_instance_class
  compute_subnet_ids = module.vpc.compute_subnet_ids
  eks_cluster_sg_id  = module.eks.cluster_security_group_id
  compute_subnets    = var.compute_subnets

  zone_id      = module.dns.zone_id
  domain_name  = var.domain_name
  cluster_name = var.cluster_name
}

module "landing" {
  source       = "../../modules/apps/landing"
  project_name = var.project_name
  env          = var.env
  domain_name  = var.domain_name
  zone_id      = module.dns.zone_id

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}
