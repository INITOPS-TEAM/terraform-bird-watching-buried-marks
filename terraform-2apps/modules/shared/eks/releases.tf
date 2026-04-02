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

resource "kubernetes_namespace_v1" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "envoy_gw_api" {
  name       = "envoy-gw"
  namespace  = kubernetes_namespace_v1.envoy_gw_api.metadata[0].name
  repository = "oci://docker.io/envoyproxy"
  version    = "1.7.1"
  chart      = "gateway-helm"

  set = [
    {
      name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
      value = aws_acm_certificate_validation.marks.certificate_arn
    },
    {
      name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-ports"
      value = "443"
      type  = "string"
    },
    {
      name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol"
      value = "http"
    }
  ]
}

resource "helm_release" "gateway" {
  name       = "gateway"
  namespace  = kubernetes_namespace_v1.buried_marks.metadata[0].name
  repository = local.repository
  version    = "0.1.0"
  chart      = "buried-marks-helm-gateway"
  set = [
    {
      name  = "listeners[0].name"
      value = "http"
    },
    {
      name  = "listeners[0].port"
      value = "80"
    },
    {
      name  = "listeners[0].protocol"
      value = "HTTP"
    }
  ]
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

resource "helm_release" "monitoring" {
  name       = "monitoring"
  namespace  = kubernetes_namespace_v1.monitoring.metadata[0].name
  repository = local.repository
  version    = "0.1.0"
  chart      = "buried-marks-helm-monitoring"

  set = [
    {
      name  = "fullnameOverride"
      value = "monitoring"
    },
    {
      name  = "kube-prometheus-stack.prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.storageClassName"
      value = "gp2-ebs"
    },
    {
      name  = "kube-prometheus-stack.alertmanager.alertmanagerSpec.storage.volumeClaimTemplate.spec.storageClassName"
      value = "gp2-ebs"
    },
    {
      name  = "kube-prometheus-stack.grafana.persistence.storageClassName"
      value = "gp2-ebs"
    },
    {
      name  = "kube-prometheus-stack.grafana.persistence.enabled"
      value = "true"
    }
  ]

  depends_on = [kubernetes_storage_class_v1.ebs_gp2]
}
