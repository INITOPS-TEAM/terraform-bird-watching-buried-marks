resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "lb" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 300
  records = [var.lb_ip]
}
