# OIDC Provider for IRSA
data "tls_certificate" "cluster" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

data "aws_ec2_managed_prefix_list" "vpc_lattice_ipv4" {
  name = "com.amazonaws.${var.aws_region}.vpc-lattice"
}
