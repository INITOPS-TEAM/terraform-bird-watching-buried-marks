resource "aws_vpclattice_service_network" "eks_api_gw" {
  name      = var.cluster_name
  auth_type = "NONE" # TODO AWS_IAM
}

resource "aws_vpclattice_service_network_vpc_association" "eks_api_gw" {
  vpc_identifier             = var.vpc_id
  service_network_identifier = aws_vpclattice_service_network.eks_api_gw.id
  #   security_group_ids         = [aws_security_group.example.id]
}

resource "aws_security_group_rule" "eks_nodes_vpc_lattice" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  prefix_list_ids   = [data.aws_ec2_managed_prefix_list.vpc_lattice_ipv4.id]
  security_group_id = aws_security_group.eks_nodes.id
}
