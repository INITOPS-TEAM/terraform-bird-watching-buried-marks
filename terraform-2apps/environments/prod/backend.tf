terraform {
  backend "s3" {
    bucket       = "prod-s3-project-buried-marks-and-birdwatching-terraform-state"
    key          = "prod-state/environments/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}
