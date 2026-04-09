resource "kubernetes_job_v1" "postgres_rds_enable_iam" {
  metadata {
    name = "postgres-rds-enable-iam"
  }
  spec {
    template {
      metadata {}
      spec {
        container {
          name    = "postgres-rds-enable-iam"
          image   = "alpine/psql:18.3"
          command = ["psql", "postgresql://${local.auth_secret["DB_USER"]}:${local.auth_secret["DB_PASSWORD"]}@${var.auth_db_endpoint}/${local.auth_secret["DB_NAME"]}?sslmode=require", "-c", "GRANT rds_iam TO ${local.auth_secret["DB_USER"]};"]
        }
        restart_policy = "Never"
      }
    }
    backoff_limit = 4
  }
  wait_for_completion = true
  timeouts {
    create = "2m"
    update = "2m"
  }
}
