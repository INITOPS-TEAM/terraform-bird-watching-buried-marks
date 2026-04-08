terraform {
  backend "s3" {
    bucket       = "dev-s3-project-buried-marks-and-birdwatching-terraform-state-01"
    key          = "dev-state/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}
