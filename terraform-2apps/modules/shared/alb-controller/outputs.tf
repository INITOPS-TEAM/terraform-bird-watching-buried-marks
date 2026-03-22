output "alb_controller_role_arn" {
  value       = aws_iam_role.alb_controller.arn
  description = "ARN of ALB controller IAM role"
}

output "helm_release_name" {
  value       = helm_release.alb_controller.name
  description = "Helm release name for ALB controller"
}
