variable "bucket_name" {
  type        = string
  description = "Full unique bucket name"
}

variable "versioning_status" {
  type        = string
  default     = "Suspended"
  description = "Enabled for DB or Suspended for images)"
}

variable "iam_instance_profile_name" {
  type    = string
  default = null
}