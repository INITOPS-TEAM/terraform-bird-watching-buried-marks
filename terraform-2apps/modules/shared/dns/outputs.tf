output "lb_domain" {
  value = aws_route53_record.lb.fqdn
}
output "zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "nameservers" {
  value = aws_route53_zone.main.name_servers
}