variable "service_name" {
  type        = string
  description = "Name of the service"
}

variable "environment" {
  type        = string
  description = "Environment like'production', 'test'"
}

variable "aws_region" {
  type        = string
  description = "AWS Region for develop infra"
}

variable "enable" {
  type        = string
  default     = true
  description = "variable to enable the services"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for your enviroment"
}

variable "cluster_identifier" {
  type        = string
  default     = ""
  description = "The cluster identifier"
}

variable "engine" {
  type        = string
  default     = "aurora"
  description = "The name of the database engine to be used for this DB cluster"
}

variable "engine_version" {
  type        = string
  default     = ""
  description = "The database engine version"
}

variable "availability_zones" {
  type        = list(string)
  default     = []
  description = "A list of EC2 Availability Zones for the DB cluster storage where DB cluster instances can be created"
}

variable "instance_availability_zone" {
  type        = string
  default     = ""
  description = "The availability zone of the instance "
}

variable "db_option_group_arn" {
  type    = string
  default = ""
}

variable "database_name" {
  type        = string
  default     = ""
  description = "Name for an automatically created database on cluster creation"
}

variable "master_username" {
  type        = string
  default     = "admin"
  description = "Username for the master DB user"

}

variable "master_password" {
  type        = string
  description = "Password for the master DB user"
  default     = ""
}

variable "copy_tags_to_snapshot" {
  type        = bool
  description = "Copy all Cluster tags to snapshots. Default is true"
  default     = true
}

variable "deletion_protection" {
  type        = bool
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted"
  default     = false
}

variable "final_snapshot_identifier" {
  type        = string
  default     = ""
  description = "The name of your final DB snapshot when this DB cluster is deleted"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted"
  default     = false
}

variable "backtrack_window" {
  type        = number
  default     = 0
  description = "The target backtrack window, in seconds. Only available for aurora engine currently"

}

variable "backup_retention_period" {
  type        = number
  default     = 1
  description = "The days to retain backups for. Default 1"
}

variable "preferred_maintenance_window" {
  type        = string
  description = "The weekly time range during which system maintenance can occur, in (UTC) e.g. wed:04:00-wed:04:30"
  default     = "sun:04:00-sun:06:00"
}

variable "preferred_backup_window" {
  type        = string
  description = "The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter"
  default     = "07:00-09:00"
}

variable "database_port" {
  type        = number
  description = "The port on which the DB accepts connections"
  default     = 3306
}

variable "vpc_security_group_ids" {
  type        = list(string)
  default     = []
  description = "List of VPC security groups to associate with the Cluster"
}

variable "allowed_cidr_rds_instance" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = ""
}

variable "snapshot_identifier" {
  type        = string
  default     = ""
  description = "The name of your DB snapshot"
}

variable "global_cluster_identifier" {
  type        = string
  default     = ""
  description = "The global cluster identifier specified on aws_rds_global_cluster"
}

variable "storage_encrypted" {
  type        = bool
  default     = false
  description = "Specifies whether the DB cluster is encrypted. The default is false"
}

variable "replication_source_identifier" {
  type        = string
  default     = ""
  description = "ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica"
}

variable "apply_immediately" {
  type        = bool
  default     = false
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window."
}

variable "db_subnet_group_name" {
  type        = string
  default     = ""
  description = "A DB subnet group to associate with this DB instance"
}

variable "db_cluster_parameter_group_name" {
  type        = string
  default     = ""
  description = "A cluster parameter group to associate with the cluster."
}

variable "kms_key_id" {
  type        = string
  default     = ""
  description = "The ARN for the KMS encryption key. When specifying kms_key_id, storage_encrypted needs to be set to true."
}

variable "iam_roles" {
  type        = list(string)
  default     = []
  description = "A List of ARNs for the IAM roles to associate to the RDS Cluster."
}

variable "iam_database_authentication_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
}

variable "engine_mode" {
  type        = string
  default     = "provisioned"
  description = "The DB engine mode of the DB cluster, either provisioned, serverless, parallelquery,global, or multimaster"
}

variable "source_region" {
  type        = string
  default     = ""
  description = "The source region for an encrypted replica DB cluster."
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  default     = []
  description = "List of log types to export to cloudwatch. If omitted, no logs will be exported"
}

variable "enable_http_endpoint" {
  type        = bool
  default     = true
  description = "Enable HTTP endpoint (data API). Only valid when engine_mode is set to serverless"
}

variable "s3_import" {
  type        = map(string)
  description = "to import db backup from s3"
  default     = {}
}

variable "scaling_configuration" {
  type        = map(string)
  description = "scaling_configuration configuration is only valid when engine_mode is set to serverless"
  default = {
    auto_pause               = true
    max_capacity             = 256
    min_capacity             = 2
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }

}
variable "vpc_id" {
  type        = string
  description = ""
  default     = ""
}

variable "timeouts" {
  type        = map(string)
  description = "The time specify to create update and delete cluster"
  default     = {}
}

variable "subnet_group_name" {
  type        = string
  default     = ""
  description = "Provides an RDS DB subnet group resource"
}

variable "subnet_group_name_prefix" {
  type        = string
  default     = ""
  description = "A DB subnet group to associate with this DB instance(db_subnet_group)"
}

variable "subnet_ids" {
  type        = list
  default     = []
  description = "A list of VPC subnet IDs (db_subnet_group)"
}

variable "aws_db_parameter_group_name" {
  type        = string
  default     = ""
  description = "Provides an RDS DB parameter group resource"
}

variable "aws_db_parameter_group_family" {
  type        = string
  default     = ""
  description = "The family of the DB parameter group(db_parameter_group)"
}

variable "instance_parameters" {
  type = list(map(string))
  default = [
    {
      apply_method = ""
      name         = ""
      value        = ""
    }
  ]
  description = "instance parameters for db_parameter_group"
}

variable "cluster_parameters" {
  type = list(map(string))
  default = [
    {
      apply_method = ""
      name         = ""
      value        = ""
    }
  ]
  description = "cluster parameters for db_parameter_group"
}

variable "aws_db_option_group_name" {
  type        = string
  default     = ""
  description = "Provides an RDS DB option group resource"
}

variable "monitoring_role_arn" {
  type        = string
  default     = ""
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
}

variable "monitoring_interval" {
  type        = number
  default     = 0
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance"
}

variable "promotion_tier" {
  type        = number
  default     = 0
  description = "Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoted to writer"
}

variable "auto_minor_version_upgrade" {
  type        = bool
  default     = true
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Default true"
}

variable "performance_insights_enabled" {
  type        = bool
  default     = false
  description = " Specifies whether Performance Insights is enabled or not"
}

variable "performance_insights_kms_key_id" {
  type        = string
  default     = ""
  description = "The ARN for the KMS key to encrypt Performance Insights data"
}

variable "publicly_accessible" {
  type        = bool
  default     = false
  description = "Bool to control if instance is publicly accessible. Default false"
}

variable "ca_cert_identifier" {
  type        = string
  default     = ""
  description = "The identifier of the CA certificate for the DB instance"
}

variable "rds_cluster_instances" {
  type        = number
  default     = 2
  description = "Number of rds cluster instance"
}

variable "instance_class" {
  type        = string
  default     = "db.r5.large"
  description = "The instance class to use"
}

variable "cidr_blocks_allowed" {
  type        = list
  default     = []
  description = "Allowed CIDR blocks for security group"
}

variable "cluster_family" {
  type        = string
  default     = "aurora5.6"
  description = "The family of the DB cluster parameter group"
}

variable rds_ingress_ports {
  type        = list(string)
  default     = [5432]
  description = "Port number that need to be add as ingress"
}


variable rds_sg_protocol {
  type        = string
  default     = "tcp"
  description = "Security group inbound protocol"
}