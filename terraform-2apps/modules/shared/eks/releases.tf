resource "kubernetes_namespace_v1" "buried_marks" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_namespace_v1" "envoy_gw_api" {
  metadata {
    name = "envoy-gateway-system"
  }
}

resource "helm_release" "envoy_gw_api" {
  name       = "envoy-gw"
  namespace  = kubernetes_namespace_v1.envoy_gw_api.metadata[0].name
  repository = "oci://docker.io/envoyproxy"
  version    = "1.5.9"
  chart      = "gateway-helm"
}

resource "helm_release" "gateway" {
  name       = "gateway"
  namespace  = kubernetes_namespace_v1.buried_marks.metadata[0].name
  repository = local.repository
  version    = "0.1.0"
  chart      = "buried-marks-helm-gateway"
  depends_on = [
    helm_release.envoy_gw_api
  ]
}

resource "helm_release" "authentication_microservice" {
  name       = "auth-service"
  namespace  = kubernetes_namespace_v1.buried_marks.metadata[0].name
  repository = local.repository
  version    = "0.1.0"
  chart      = "buried-marks-helm-authentication-microservice"
  depends_on = [
    helm_release.gateway
  ]
  set = [{
    name  = "fullnameOverride"
    value = "authentication-microservice"
  }]
}

resource "helm_release" "map_microservice" {
  name       = "map-service"
  namespace  = kubernetes_namespace_v1.buried_marks.metadata[0].name
  repository = local.repository
  version    = "0.1.0"
  chart      = "buried-marks-helm-map-microservice"
  depends_on = [
    helm_release.gateway
  ]
  set = [{
    name  = "fullnameOverride"
    value = "map-microservice"
  }]
}

resource "helm_release" "mail_microservice" {
  name       = "mail-service"
  namespace  = kubernetes_namespace_v1.buried_marks.metadata[0].name
  repository = local.repository
  version    = "0.1.0"
  chart      = "buried-marks-helm-mail-microservice"
  depends_on = [
    helm_release.gateway
  ]
  set = [{
    name  = "fullnameOverride"
    value = "mail-microservice"
  }]
}

resource "helm_release" "voting_microservice" {
  name       = "voting-service"
  namespace  = kubernetes_namespace_v1.buried_marks.metadata[0].name
  repository = local.repository
  version    = "0.1.0"
  chart      = "buried-marks-helm-voting-microservice"
  depends_on = [
    helm_release.gateway
  ]
  set = [{
    name  = "fullnameOverride"
    value = "voting-microservice"
  }]
}

resource "helm_release" "login_front" {
  name       = "login-front"
  namespace  = kubernetes_namespace_v1.buried_marks.metadata[0].name
  repository = local.repository
  version    = "0.1.0"
  chart      = "buried-marks-helm-login-front"
  depends_on = [
    helm_release.authentication_microservice
  ]
  set = [{
    name  = "fullnameOverride"
    value = "login-front"
  }]
}

resource "helm_release" "map_front" {
  name       = "map-front"
  namespace  = kubernetes_namespace_v1.buried_marks.metadata[0].name
  repository = local.repository
  version    = "0.1.0"
  chart      = "buried-marks-helm-map-front"
  depends_on = [
    helm_release.map_microservice
  ]
  set = [{
    name  = "fullnameOverride"
    value = "map-front"
  }]
}

resource "helm_release" "admin_front" {
  name       = "admin-front"
  namespace  = kubernetes_namespace_v1.buried_marks.metadata[0].name
  repository = local.repository
  version    = "0.1.0"
  chart      = "buried-marks-helm-admin-front"
  depends_on = [
    helm_release.mail_microservice
  ]
  set = [{
    name  = "fullnameOverride"
    value = "admin-front"
  }]
}

resource "helm_release" "voting_front" {
  name       = "voting-front"
  namespace  = kubernetes_namespace_v1.buried_marks.metadata[0].name
  repository = local.repository
  version    = "0.1.0"
  chart      = "buried-marks-helm-voting-front"
  depends_on = [
    helm_release.voting_microservice
  ]
  set = [{
    name  = "fullnameOverride"
    value = "voting-front"
  }]
}
