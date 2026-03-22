# Adding rights to the bucket
resource "aws_iam_policy" "birdwatching_s3" {
  name = "${var.project_name}-${var.env}-birdwatching-s3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:PutObject", "s3:GetObject", "s3:ListBucket", "s3:DeleteObject"]
      Resource = ["arn:aws:s3:::${var.project_name}-${var.env}-*", "arn:aws:s3:::${var.project_name}-${var.env}-*/*"]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3" {
  role       = var.app_role_name
  policy_arn = aws_iam_policy.birdwatching_s3.arn
}
