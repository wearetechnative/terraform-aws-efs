resource "aws_efs_file_system" "efs" {
  creation_token = "my-product"
  encrypted = true
  kms_key_id = var.kms_key_id
  performance_mode = var.efs_performance_mode

  tags = {
    Name = var.name
  }

  protection {
    replication_overwrite = var.protection
  }

#   lifecycle_policy {
#     transition_to_ia = "AFTER_30_DAYS"
#     transition_to_archive = "AFTER_30_DAYS"
#     transition_to_primary_storage_class = "AFTER_1_ACCESS"
#   }
}
