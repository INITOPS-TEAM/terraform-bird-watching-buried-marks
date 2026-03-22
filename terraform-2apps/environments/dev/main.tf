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

  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  eks_subnets  = [module.vpc.eks_subnet_id]
  node_subnets = [module.vpc.compute_subnet_id]

  desired_size   = 2
  min_size       = 1
  max_size       = 3
  instance_types = ["t3.small"]
}

module "alb_controller" {
  source = "../../modules/shared/alb-controller"

  cluster_name       = var.cluster_name
  oidc_provider_arn  = module.eks.oidc_provider_arn
  oidc_provider_url  = module.eks.oidc_provider_url
  vpc_id             = module.vpc.vpc_id
  aws_region         = var.aws_region

  depends_on = [module.eks]
}

module "iam" {
  source = "../../modules/shared/IAM"

  project_name = var.project_name
  env          = var.env
}

module "jenkins" {
  source = "../../modules/shared/Jenkins"

  project_name          = var.project_name
  env                   = var.env
  ami_id                = var.ami_id
  instance_type_jenkins = var.instance_type_jenkins
  consul_sg_id = module.birdwatching.consul_sg_id
  nat_az                = var.nat_az
  key_name              = aws_key_pair.this.key_name
  vpc_id                = module.vpc.vpc_id
  vpc_cidr              = module.vpc.vpc_cidr
  compute_subnet_id     = module.vpc.compute_subnet_id
}

module "birdwatching" {
  source = "../../modules/apps/birdwatching"

  project_name       = var.project_name
  env                = var.env
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = aws_key_pair.this.key_name
  app_instance_count = var.app_instance_count
  domain_name        = var.domain_name

  vpc_id            = module.vpc.vpc_id
  vpc_cidr          = module.vpc.vpc_cidr
  compute_subnet_id = module.vpc.compute_subnet_id
  public_subnet_id  = module.vpc.public_subnet_id

  jenkins_sg_id             = module.jenkins.jenkins_sg_id
  app_role_name             = module.iam.app_role_name
  iam_instance_profile_name = module.iam.app_instance_profile_name
  ssm_instance_profile_name = module.iam.ssm_instance_profile_name
}
