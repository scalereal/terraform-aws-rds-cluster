
output "cluster_info" {
  value = aws_rds_cluster.rds_cluster[0].arn
}

output "database_name" {
  value = aws_rds_cluster.rds_cluster[0].database_name
}

output "master_username" {
  value = aws_rds_cluster.rds_cluster[0].master_username
}

output "master_password" {
  value = aws_rds_cluster.rds_cluster[0].master_password
  sensitive = true
}

#output "hosted_zone_id" {
#  value = aws_rds_cluster_instance[0].hosted_zone_id
#}

output "cluster_identifier" {
  value = aws_rds_cluster.rds_cluster[0].cluster_identifier
}

output "arn" {
  value = aws_rds_cluster.rds_cluster[0].arn
}

output "endpoint" {
  value = aws_rds_cluster.rds_cluster[0].endpoint
}

output "reader_endpoint" {
  value = aws_rds_cluster.rds_cluster[0].reader_endpoint
}

output "replicas_host" {
  value = aws_rds_cluster_instance.cluster_instance[*].cluster_identifier
}

#output "cluster_security_groups" {
#  value = aws_security_group.this[0].egress.cidr_blocks
#}

output "db_cluster_parameter_group_name" {
  value = aws_rds_cluster.rds_cluster[0].db_cluster_parameter_group_name
}

output "scaling_configuration" {
  value = aws_rds_cluster.rds_cluster[0].scaling_configuration
}
