output "host_postgres_rds" {
  value       = aws_db_instance.auth.address
  description = "Host name for auth/voting RDS"
}

output "host_mariadb_rds" {
  value       = aws_db_instance.map.address
  description = "Host name for map RDS"
}
