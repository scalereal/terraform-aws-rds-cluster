service_name = "scalereal"
environment  = "test"
aws_region   = "ap-south-1"
engine       = "aurora"
db_password  = "redhat123"
#availability_zones     = ["ap-south-1a", "ap-south-1b"]
master_username        = "admin"
master_password        = "redhat123"
vpc_security_group_ids = ["sg-ecb7ed8f"]
engine_mode            = "serverless"
subnet_ids             = ["subnet-688de024", "subnet-16a29e7e"]
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






