/*data "aws_route53_zone" "selected" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "lb" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 60
  records = [var.lb_ip]
}
*/


resource "aws_route53_zone" "env_subzone" {
  name = "${var.env}.birds.pp.ua"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "app_lb" {
  zone_id = aws_route53_zone.env_subzone.zone_id
  name    = "${var.env}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.lb_dns_name
    zone_id                = var.lb_zone_id
    evaluate_target_health = true
  }
}
