resource "helm_release" "map_microservice" {
  name       = "map-service"
  namespace  = var.namespace
  repository = local.repository
  version    = "0.1.0"
  chart      = "buried-marks-helm-map-microservice"
}
