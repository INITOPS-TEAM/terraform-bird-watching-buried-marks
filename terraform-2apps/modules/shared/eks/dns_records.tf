data "kubernetes_resources" "envoy_lb" {
  api_version    = "v1"
  kind           = "Service"
  namespace      = kubernetes_namespace_v1.envoy_gw_api.metadata[0].name
  label_selector = "gateway.envoyproxy.io/owning-gateway-name=buried-marks-gateway"
  depends_on     = [helm_release.envoy_gw_api]
}

resource "aws_route53_record" "marks_custom_domain" {
  zone_id = var.zone_id
  name    = "marks.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [data.kubernetes_resources.envoy_lb.objects[0].status.loadBalancer.ingress[0].hostname]
}
