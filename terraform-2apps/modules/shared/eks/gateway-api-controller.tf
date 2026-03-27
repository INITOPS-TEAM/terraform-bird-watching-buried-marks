
resource "aws_iam_policy" "gateway_api_controller" {
  name = "VPCLatticeControllerIAMPolicy"
  # TODO MAYBE IT COULD BE DOWNLOADED FROM LINK https://raw.githubusercontent.com/aws/aws-application-networking-k8s/main/files/controller-installation/recommended-inline-policy.json
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "vpc-lattice:*",
          "ec2:DescribeVpcs",
          "ec2:DescribeSubnets",
          "ec2:DescribeTags",
          "ec2:DescribeSecurityGroups",
          "logs:CreateLogDelivery",
          "logs:GetLogDelivery",
          "logs:DescribeLogGroups",
          "logs:PutResourcePolicy",
          "logs:DescribeResourcePolicies",
          "logs:UpdateLogDelivery",
          "logs:DeleteLogDelivery",
          "logs:ListLogDeliveries",
          "tag:GetResources",
          "firehose:TagDeliveryStream",
          "s3:GetBucketPolicy",
          "s3:PutBucketPolicy",
          "tag:TagResources",
          "tag:UntagResources"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:CreateServiceLinkedRole",
        "Resource" : "arn:aws:iam::*:role/aws-service-role/vpc-lattice.amazonaws.com/AWSServiceRoleForVpcLattice",
        "Condition" : {
          "StringLike" : {
            "iam:AWSServiceName" : "vpc-lattice.amazonaws.com"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:CreateServiceLinkedRole",
        "Resource" : "arn:aws:iam::*:role/aws-service-role/delivery.logs.amazonaws.com/AWSServiceRoleForLogDelivery",
        "Condition" : {
          "StringLike" : {
            "iam:AWSServiceName" : "delivery.logs.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role" "gateway_api_controller" {
  name = "aws-gateway-api-controller"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowEksAuthToAssumeRoleForPodIdentity",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "pods.eks.amazonaws.com"
        },
        "Action" : [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "gateway_api_controller" {
  role       = aws_iam_role.gateway_api_controller.name
  policy_arn = aws_iam_policy.gateway_api_controller.arn
}

resource "aws_eks_pod_identity_association" "gateway_api_controller" {
  cluster_name    = aws_eks_cluster.main.name
  namespace       = "aws-application-networking-system"
  service_account = "gateway-api-controller"
  role_arn        = aws_iam_role.gateway_api_controller.arn
}
