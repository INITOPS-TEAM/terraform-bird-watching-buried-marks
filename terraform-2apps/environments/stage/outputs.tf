# output "lb_public_ip" {
#   value = module.birdwatching.lb_public_ip
# }

# output "lb_domain" {
#   value = module.birdwatching.lb_domain
# }
#
# output "nameservers" {
#   value = module.birdwatching.nameservers
# }

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "landing_s3_bucket_name" {
  description = "Name of the S3 bucket for the landing page"
  value       = module.landing.s3_bucket_name
}

output "landing_cloudfront_id" {
  description = "ID of the CloudFront distribution"
  value       = module.landing.cloudfront_distribution_id
}