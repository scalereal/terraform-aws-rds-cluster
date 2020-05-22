
resource "aws_rds_cluster" "rds_cluster" {
  count                               = var.enable ? 1 : 0
  cluster_identifier                  = local.cluster_identifier
  engine                              = var.engine
  engine_version                      = var.engine_version
  availability_zones                  = var.availability_zones
  database_name                       = var.database_name
  master_username                     = var.master_username
  master_password                     = local.master_password
  preferred_maintenance_window        = var.preferred_maintenance_window
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  deletion_protection                 = var.deletion_protection
  final_snapshot_identifier           = var.skip_final_snapshot == true ? null : local.final_snapshot_identifier
  skip_final_snapshot                 = var.skip_final_snapshot
  backtrack_window                    = var.engine == "aurora" ? null : var.backtrack_window
  backup_retention_period             = var.backup_retention_period
  preferred_backup_window             = var.preferred_backup_window
  port                                = var.database_port
  vpc_security_group_ids              = concat(flatten([join("", aws_security_group.this[0].*.id), var.vpc_security_group_ids]))
  snapshot_identifier                 = var.snapshot_identifier
  global_cluster_identifier           = var.global_cluster_identifier
  storage_encrypted                   = var.storage_encrypted
  replication_source_identifier       = var.replication_source_identifier
  apply_immediately                   = var.apply_immediately
  db_subnet_group_name                = aws_db_subnet_group.this[0].name
  db_cluster_parameter_group_name     = aws_rds_cluster_parameter_group.this[0].name
  kms_key_id                          = var.kms_key_id
  iam_roles                           = var.iam_roles
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  engine_mode                         = var.engine_mode
  source_region                       = var.source_region
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  enable_http_endpoint                = var.enable_http_endpoint
  tags                                = var.tags

  dynamic "s3_import" {
    for_each = length(keys(var.s3_import)) == 0 ? [] : [var.s3_import]
    content {
      source_engine         = lookup(s3_import.value, "source_engine", null)
      source_engine_version = lookup(s3_import.value, "source_engine_version", null)
      bucket_name           = lookup(s3_import.value, "bucket_name", null)
      bucket_prefix         = lookup(s3_import.value, "bucket_prefix", null)
      ingestion_role        = lookup(s3_import.value, "ingestion_role", null)

    }
  }

  dynamic "scaling_configuration" {
    for_each = var.engine_mode == "serverless" ? [var.scaling_configuration] : []
    content {
      auto_pause               = lookup(scaling_configuration.value, "auto_pause", null)
      max_capacity             = lookup(scaling_configuration.value, "max_capacity", null)
      min_capacity             = lookup(scaling_configuration.value, "min_capacity", null)
      seconds_until_auto_pause = lookup(scaling_configuration.value, "seconds_until_auto_pause", null)
      timeout_action           = lookup(scaling_configuration.value, "timeout_action", null)
    }
  }

  dynamic "timeouts" {
    for_each = length(keys(var.timeouts)) == 0 ? [] : [var.timeouts]
    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }
}

resource "aws_db_subnet_group" "this" {
  count       = var.enable ? 1 : 0
  name        = format("%s-subnet-group", local.cluster_identifier)
  description = "add subnets to allow subnets for DB cluster"
  subnet_ids  = var.subnet_ids
  tags        = local.tags
}

resource "aws_rds_cluster_parameter_group" "this" {
  count  = var.enable ? 1 : 0
  name   = format("%s-db-cluster-parameter-group", local.cluster_identifier)
  family = var.cluster_family
  tags   = local.tags

  dynamic "parameter" {
    for_each = var.cluster_parameters
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = lookup(parameter.value, "name", null)
      value        = lookup(parameter.value, "value", null)
    }
  }
}

resource "aws_db_parameter_group" "this" {
  count  = var.enable ? 1 : 0
  name   = format("%s-db-instance-parameter-group", local.cluster_identifier)
  family = var.cluster_family
  tags   = local.tags

  dynamic "parameter" {
    for_each = var.instance_parameters
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = lookup(parameter.value, "name", null)
      value        = lookup(parameter.value, "value", null)
    }
  }
}


resource "aws_rds_cluster_instance" "cluster_instance" {
  count                           = var.engine_mode == "serverless" ? 0 : var.rds_cluster_instances
  identifier                      = format("%s-instance-%d", local.cluster_identifier, "${count.index + 1}")
  cluster_identifier              = aws_rds_cluster.rds_cluster[0].cluster_identifier
  engine                          = var.engine
  instance_class                  = var.instance_class
  engine_version                  = var.engine_version
  publicly_accessible             = var.publicly_accessible
  db_subnet_group_name            = aws_db_subnet_group.this[0].name
  db_parameter_group_name         = aws_db_parameter_group.this[0].name
  apply_immediately               = var.apply_immediately
  monitoring_role_arn             = var.monitoring_role_arn
  monitoring_interval             = var.monitoring_interval
  promotion_tier                  = var.promotion_tier
  availability_zone               = var.instance_availability_zone
  preferred_maintenance_window    = var.preferred_maintenance_window
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  performance_insights_enabled    = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_kms_key_id
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  ca_cert_identifier              = var.ca_cert_identifier
  tags                            = local.tags
  dynamic "timeouts" {
    for_each = length(keys(var.timeouts)) == 0 ? [] : [var.timeouts]
    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }
}

resource "aws_security_group" "this" {
  count  = var.enable ? 1 : 0
  name   = format("%s-security-group", local.cluster_identifier)
  vpc_id = var.vpc_id
  tags   = local.tags

  ingress {
    from_port       = var.database_port
    to_port         = var.database_port
    protocol        = "tcp"
    security_groups = var.vpc_security_group_ids
  }

  ingress {
    from_port   = var.database_port
    to_port     = var.database_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_rds_instance
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "random_password" "password" {
  count            = length(var.master_password) == 0 && var.enable ? 1 : 0
  length           = 16
  special          = true
  override_special = "_%@"
}

locals {
  cluster_identifier        = length(var.cluster_identifier) == 0 ? format("%s-%s-rds-cluster", var.service_name, var.environment) : var.cluster_identifier
  tags                      = merge(var.tags, map("Name", format("%s-%s-rds-cluster", var.service_name, var.environment)))
  master_password           = var.master_password != "" ? var.master_password : random_password.password[0].result
  final_snapshot_identifier = length(var.final_snapshot_identifier) != 0 ? var.final_snapshot_identifier : format("%s-%s-snapshot", var.service_name, var.environment)
}
