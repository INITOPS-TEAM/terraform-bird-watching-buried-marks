output "lb_domain" {
  value = aws_route53_record.lb.fqdn
}
output "zone_id" {
  value = data.aws_route53_zone.selected.zone_id
}

output "nameservers" {
  value = aws_route53_zone.env_subzone.name_servers
}
