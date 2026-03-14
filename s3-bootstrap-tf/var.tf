variable "aws_region" {
  description = "AWS region for the resource"
  type        = string
}

variable "s3_bucket_name" {
  description = "The unique name of the S3 bucket"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resource"
  type        = map(string)
  default = {
    env = "dev"
    ManagedBy   = "Terraform"
    Project     = "buried-marks-birdwatching"
  }
}
