# rds-cluster-aws-terraform
`rds-cluster-aws-terraform` module is to create RDS Cluster for one or more DB instances compatible with aurora, aurora-mysql and aurora-postgresql

Supporte Features:
    
1. [RDS Cluster](https://www.terraform.io/docs/providers/aws/r/rds_cluster.html)
2. [RDS Cluster Instance](https://www.terraform.io/docs/providers/aws/r/rds_cluster_instance.html)
3. [RDS DB cluster parameter group](https://www.terraform.io/docs/providers/aws/r/rds_cluster_parameter_group.html)
4. [RDS DB subnet group](https://www.terraform.io/docs/providers/aws/r/db_subnet_group.html)
5. [RDS DB parameter group](https://www.terraform.io/docs/providers/aws/r/db_parameter_group.html) 


## Usage
### Provisioned
```hcl
module "rds-cluster-aws-terraform" {
  source                 = "git::https://github.com/scalereal/rds-cluster-aws-terraform.git"
  service_name           = "scalereal"
  environment            = "test"
  aws_region             = "ap-south-1"
  engine                 = "aurora"
  availability_zones     = ["ap-south-1a", "ap-south-1b"]
  master_username        = "admin"
  master_password        = "admin123"
  vpc_security_group_ids = ["sg-xxxxx"]
  engine_mode            = "provisioned"
  subnet_ids             = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"]
  rds_cluster_instances  = 2
  instance_class         = "db.r5.large"
  cluster_family         = "aurora5.6"
  tags = {
    owner       = "scalereal"
    application = "scalerealapp"
  }
}
```

### Serverless
```hcl
module "rds-cluster-aws-terraform" {
  source                 = "git::https://github.com/scalereal/rds-cluster-aws-terraform.git" 
  environment  = "test"
  aws_region   = "ap-south-1"
  engine       = "aurora"
  master_username        = "admin"
  master_password        = "admin123"
  vpc_security_group_ids = ["sg-XXXXXXX"]
  engine_mode            = "serverless"
  subnet_ids             = ["subnet-XXXXXXXX", "subnet-XXXXXXXX"]
  instance_class         = "db.r5.large"
  cluster_family         = "aurora5.6"
  database_port          = "3306"
  scaling_configuration = {
    auto_pause               = true
    max_capacity             = 256
    min_capacity             = 2
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}
```

## Providers

| Name | Version |
|------|---------|
| aws | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_region | AWS Region for develop infra | `string` | n/a | no |
| environment | Environment like production, test | `string` | n/a | yes |
| service\_name | Service Name | `string` | n/a | yes |
| tags | Tags for enviroment | `map(string)` | n/a | no |
| cluster_identifier | The cluster identifier | `string` | n/a | yes |
| engine| To delete bucket forcefully | `bool` | `false` | no |
|engine_version | Data encryption algorithm for bucket | `string` | `AES256` | no |
|availability_zones | Key Management Service for encryption required `ARN` | `string` | n/a | no |
|database_name|The port on which the DB accepts connections|`number`|`3306`|no|
|master_username|Username for the master DB user|`string`|`admin`|no|
|master_password|Password for the master DB user| `string`|n/a| no|
|preferred_maintenance_window|The weekly time range during which system maintenance can occur|`string`|`sun:04:00-sun:06:00`|no
|copy_tags_to_snapshot|Copy all Cluster tags to snapshots| `bool`|`true`|no
|deletion_protection|If the DB instance should have deletion protection enabled. The database can't be deleted|`bool`|`false`|no|
|final_snapshot_identifier|The name of your final DB snapshot when this DB cluster is deleted|`string`|n/a|no|
|skip_final_snapshot|Determines whether a final DB snapshot is created before the DB cluster is deleted | `bool`| `false`| no |
|backtrack_window|The target backtrack window, in seconds. Only available for aurora engine currently|`number`| `0` | no|
|backup_retention_period|The days to retain backups for|`number` |`1`|no|
|preferred_backup_window|The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter|`string`|`07:00-09:00`|no|
|database_port|The port on which the DB accepts connections|`number`|`3306`|no|
|vpc_security_group_ids|List of VPC security groups to associate with the Cluster|`list(string)`|n/a|yes|
|snapshot_identifier|The name of your DB snapshot|`string`|n/a|no|
|global_cluster_identifier|The global cluster identifier specified on aws_rds_global_cluster|`string`|n/a|no|
|storage_encrypted|Specifies whether the DB cluster is encrypted. The default is false|`bool`|`false`|no|
|replication_source_identifier|ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica|`string`|n/a|no|
|apply_immediately|Specifies whether any cluster modifications are applied immediately, or during the next maintenance window|`bool`|`false`|no|
|var.kms_key_id|The ARN for the KMS encryption key. When specifying kms_key_id, storage_encrypted needs to be set to true|`string`|n/a|no|
|var.iam_database_authentication_enabled|Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled|`bool`|`false`|no|
|var.engine_mode|The DB engine mode of the DB cluster, either provisioned, serverless, parallelquery,global, or multimaster|`string`|`provisioned`|no|
|var.source_region|The source region for an encrypted replica DB cluster|`string`|n/a|no|
|var.enabled_cloudwatch_logs_exports|List of log types to export to cloudwatch. If omitted, no logs will be exported|`list(string)`|n/a|no|
|enable_http_endpoint|Enable HTTP endpoint (data API). Only valid when engine_mode is set to serverless|`bool`|`true`|no|
|s3_import|to import db backup from s3|`map(string)`|n/a|no|
|scaling_configuration|scaling_configuration configuration is only valid when engine_mode is set to serverless|`map(string)`|n/a|no
|timeouts|The time specify to create update and delete cluste|`map(string)`|n/a|no|
|subnet_ids|A list of VPC subnet IDs (db_subnet_group)|`list[string]`|n/a|no|
|cluster_family|The family of the DB cluster parameter group|`string`|n/a|yes|
|cluster_parameters|cluster parameters for db_parameter_group|`list(map(string))`|n/a|no|
|instance_parameters|instance parameters for db_parameter_group|`list(map(string))`|n/a|no|
|instance_class|The instance class to use|`string`|n/a|yes|
|engine_version|The database engine version|`string`|n/a|no|
|publicly_accessible|Bool to control if instance is publicly accessible|`bool`|`false`|no|
|instance_availability_zone|The availability zone of the instance|`string`|n/a|no|
|vpc_id|vpc_id for enviroment|`string`|n/a|no|


## Outputs
