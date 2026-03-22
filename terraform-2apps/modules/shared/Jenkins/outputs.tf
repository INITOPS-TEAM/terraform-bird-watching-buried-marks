output "jenkins_instance_profile_name" {
  value       = aws_iam_instance_profile.jenkins.name
}
output "jenkins_sg_id" {
  value       = aws_security_group.jenkins.id
}
