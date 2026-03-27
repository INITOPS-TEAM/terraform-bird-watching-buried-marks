resource "aws_db_subnet_group" "this" {
    name       = "${var.project_name}-${var.env}-db-subnet-group"
    subnet_ids = var.compute_subnet_ids

    tags = merge(local.common_tags, {
        Name = "${var.project_name}-${var.env}-db-subnet-group"
    })
}

# RDS Security Group
resource "aws_security_group" "rds" {
    name        = "${var.project_name}-${var.env}-rds-sg"
    description = "Security group for RDS"
    vpc_id      = var.vpc_id

    tags = merge(local.common_tags, {
        Name = "${var.project_name}-${var.env}-rds-sg"
    })
}

# RDS Security Group Rules
resource "aws_vpc_security_group_ingress_rule" "rds_postgres_from_eks" {
    security_group_id            = aws_security_group.rds.id
    referenced_security_group_id = var.eks_nodes_sg_id
    from_port                    = 5432
    to_port                      = 5432
    ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "rds_mariadb_from_eks" {
    security_group_id            = aws_security_group.rds.id
    referenced_security_group_id = var.eks_nodes_sg_id
    from_port                    = 3306
    to_port                      = 3306
    ip_protocol                  = "tcp"
}

# Postgres for the Auth service and voting service, MariaDB for the map service
resource "aws_db_instance" "auth" {
    identifier     = "${var.app2}-${var.env}-auth-db"
    engine         = "postgres"
    engine_version = "16"
    db_name        = local.auth_secret["DB_NAME"]
    username       = local.auth_secret["DB_USER"]
    password       = local.auth_secret["DB_PASSWORD"]

    instance_class         = local.db_defaults.instance_class
    allocated_storage      = local.db_defaults.allocated_storage
    db_subnet_group_name   = local.db_defaults.db_subnet_group_name
    vpc_security_group_ids = local.db_defaults.vpc_security_group_ids
    skip_final_snapshot    = local.db_defaults.skip_final_snapshot
    final_snapshot_identifier = var.env == "prod" ? "${var.app2}-${var.env}-auth-final" : null

    tags = merge(local.common_tags, {
        Name = "${var.app2}-${var.env}-auth-db"
    })
}

resource "aws_db_instance" "map" {
    identifier     = "${var.app2}-${var.env}-map-db"
    engine         = "mariadb"
    engine_version = "10.11"
    db_name        = local.map_secret["MARIADB_DATABASE"]
    username       = local.map_secret["MARIADB_USER"]
    password       = local.map_secret["MARIADB_PASSWORD"]

    instance_class         = local.db_defaults.instance_class
    allocated_storage      = local.db_defaults.allocated_storage
    db_subnet_group_name   = local.db_defaults.db_subnet_group_name
    vpc_security_group_ids = local.db_defaults.vpc_security_group_ids
    skip_final_snapshot    = local.db_defaults.skip_final_snapshot
    final_snapshot_identifier = var.env == "prod" ? "${var.app2}-${var.env}-map-final" : null

    tags = merge(local.common_tags, {
        Name = "${var.app2}-${var.env}-map-db"
    })
}

resource "aws_db_instance" "voting" {
    identifier     = "${var.app2}-${var.env}-voting-db"
    engine         = "postgres"
    engine_version = "16"
    db_name        = local.voting_secret["POSTGRES_DB"]
    username       = local.voting_secret["POSTGRES_USER"]
    password       = local.voting_secret["POSTGRES_PASSWORD"]

    instance_class         = local.db_defaults.instance_class
    allocated_storage      = local.db_defaults.allocated_storage
    db_subnet_group_name   = local.db_defaults.db_subnet_group_name
    vpc_security_group_ids = local.db_defaults.vpc_security_group_ids
    skip_final_snapshot    = local.db_defaults.skip_final_snapshot
    final_snapshot_identifier = var.env == "prod" ? "${var.app2}-${var.env}-voting-final" : null

    tags = merge(local.common_tags, {
        Name = "${var.app2}-${var.env}-voting-db"
    })
}
