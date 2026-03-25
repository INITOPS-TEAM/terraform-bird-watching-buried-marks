output "lb_public_ip" {
  value = aws_instance.lb.public_ip
}

output "lb_domain" {
  value = module.dns.lb_domain
}
output "nameservers" {
  value = module.dns.nameservers
}

output "consul_sg_id" {
  value = aws_security_group.consul.id
}
