service_name           = "scalereal"
environment            = "test"
aws_region             = "ap-south-1"
engine                 = "aurora"
availability_zones     = ["ap-south-1a", "ap-south-1b"]
master_username        = "admin"
master_password        = "admin123"
vpc_security_group_ids = ["sg-ecb7ed8f"]
engine_mode            = "provisioned"
subnet_ids             = ["subnet-688de024", "subnet-16a29e7e"]
rds_cluster_instances  = 2
instance_class         = "db.r5.large"
cluster_family         = "aurora5.6"
tags = {
  service     = "scalereal"
  environment = "test"
}
