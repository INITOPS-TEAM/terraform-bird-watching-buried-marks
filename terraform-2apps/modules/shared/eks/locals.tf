locals {
  repository  = "oci://${var.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/"
  eks_rds_sa  = ["auth-service", "map-service", "voting-service"]
  auth_secret = jsondecode(data.aws_secretsmanager_secret_version.auth.secret_string)
  map_secret  = jsondecode(data.aws_secretsmanager_secret_version.map.secret_string)
  buried_marks_media = {
    "dev" : "dev-buried-marks-media-01",
    "stage" : "stage-buried-marks-media",
    "prod" : "prod-buried-marks-media"
  }
}
