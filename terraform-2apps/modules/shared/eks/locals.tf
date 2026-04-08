locals {
  repository = "oci://${var.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/"
  eks_rds_sa = ["auth-service", "map-service", "voting-service", "my-rds-sa"] #check
}
