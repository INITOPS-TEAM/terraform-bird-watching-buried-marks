resource "helm_release" "eso" {
    name             = "${var.env}-${var.app2}-external-secrets"
    repository       = "https://charts.external-secrets.io"
    chart            = "external-secrets"
    namespace        = "${var.env}-external-secrets"
    create_namespace = true
    version          = var.ver_eso
}

data "aws_caller_identity" "current" {}

resource "kubernetes_namespace_v1" "buried_marks" {
    metadata {
        name = var.app2
    }
}

resource "aws_iam_user" "eso" {
    name = "${var.env}-eso-user"
}

resource "aws_iam_user_policy" "eso_sm" {
    name = "eso-sm-read"
    user = aws_iam_user.eso.name

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Action = [
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret"
            ]
            Resource = "arn:aws:secretsmanager:${var.aws_region}:${data.aws_caller_identity.current.account_id}:secret:${var.app2}/*"       
            }]
    })
}

resource "aws_iam_access_key" "eso" {
    user = aws_iam_user.eso.name
}

resource "kubernetes_secret_v1" "eso_aws_creds" {
    metadata {
        name      = "aws-sm-credentials"
        namespace = kubernetes_namespace_v1.buried_marks.metadata[0].name
    }

    data = {
        "access-key"        = aws_iam_access_key.eso.id
        "secret-access-key" = aws_iam_access_key.eso.secret
    }

    depends_on = [kubernetes_namespace_v1.buried_marks]
    }