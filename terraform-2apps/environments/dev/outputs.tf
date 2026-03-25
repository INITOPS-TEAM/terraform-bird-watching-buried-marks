output "lb_public_ip" {
  value = module.birdwatching.lb_public_ip
}

output "lb_domain" {
  value = module.birdwatching.lb_domain
}

output "nameservers" {
  value = module.birdwatching.nameservers
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
