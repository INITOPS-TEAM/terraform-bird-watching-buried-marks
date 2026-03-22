resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# S3 for DB and S3 for imeges 
module "s3_images" {
  source = "../../shared/S3"
  bucket_name       = "${var.project_name}-${var.env}-images-${random_id.bucket_suffix.hex}"
  versioning_status = "Suspended"
}

module "s3_reports" {
  source            = "../../shared/S3"
  bucket_name       = "${var.project_name}-${var.env}-reports-${random_id.bucket_suffix.hex}"
  versioning_status = "Enabled"
}

module "s3_db_backup" {
  source = "../../shared/S3"
  bucket_name       = "${var.project_name}-${var.env}-db-backup-${random_id.bucket_suffix.hex}"
  versioning_status = "Enabled"
}

module "dns" {
  source = "../../shared/dns"
  env         = var.env
  domain_name = var.domain_name
  lb_ip       = aws_instance.lb.public_ip
}
