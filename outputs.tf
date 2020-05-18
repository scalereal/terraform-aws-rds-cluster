
output "cluster_info" {
  value = aws_rds_cluster.rds_cluster
}

output "database_name" {
  value = aws_rds_cluster.rds_cluster[0].database_name
}

output "master_username" {
  value = aws_rds_cluster.rds_cluster[0].master_username
}

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

output "cluster_security_groups" {
  value = aws_security_group.this[0].id
}
