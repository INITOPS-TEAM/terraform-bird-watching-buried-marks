data "aws_secretsmanager_secret_version" "auth" {
    secret_id = "buried-marks/auth-service"
}

data "aws_secretsmanager_secret_version" "map" {
    secret_id = "buried-marks/map-service"
}

data "aws_secretsmanager_secret_version" "voting" {
    secret_id = "buried-marks/voting-service"
}

locals {
    auth_secret   = jsondecode(data.aws_secretsmanager_secret_version.auth.secret_string)
    map_secret    = jsondecode(data.aws_secretsmanager_secret_version.map.secret_string)
    voting_secret = jsondecode(data.aws_secretsmanager_secret_version.voting.secret_string)

    db_defaults = {
        instance_class         = var.db_instance_class
        allocated_storage      = 5
        db_subnet_group_name   = aws_db_subnet_group.this.name
        vpc_security_group_ids = [aws_security_group.rds.id]
        skip_final_snapshot    = var.env ==  false
    
    }
    common_tags = {
    Environment = var.env
    Project     = var.project_name
    App         = var.app2
    ManagedBy   = "Terraform"
    }
}



