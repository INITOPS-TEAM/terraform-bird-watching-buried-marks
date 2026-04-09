# OIDC Provider for IRSA
data "tls_certificate" "cluster" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

data "aws_secretsmanager_secret_version" "auth" {
  secret_id = "buried-marks/auth-service"
}
