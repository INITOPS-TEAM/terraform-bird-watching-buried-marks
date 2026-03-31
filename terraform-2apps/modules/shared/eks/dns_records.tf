data "kubernetes_service_v1" "envoy_lb" {
  metadata {
    name      = "envoy-buried-marks-buried-marks-gateway-d1eb6c52"
    namespace = kubernetes_namespace_v1.envoy_gw_api.metadata[0].name
  }

  depends_on = [helm_release.envoy_gw_api]
}

resource "aws_route53_record" "marks_custom_domain" {
  zone_id = var.zone_id
  name    = "marks.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300

  records = [data.kubernetes_service_v1.envoy_lb.status.0.load_balancer.0.ingress.0.hostname]
}
