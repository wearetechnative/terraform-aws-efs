resource "aws_efs_file_system" "efs" {
  creation_token   = var.token
  encrypted        = true
  kms_key_id       = var.kms_key_id
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


resource "aws_efs_mount_target" "efs" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_id
  security_groups = var.security_groups
}

data "aws_iam_policy_document" "efs" {
  statement {
    sid    = "EFS policy"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "elasticfilesystem:ClientRootAccess",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientMount"
    ]

    resources = [aws_efs_file_system.efs.arn]

    condition {
      test     = "Bool"
      variable = "elasticfilesystem:AccessedViaMountTarget"
      values   = ["true"]
    }
  }
}

resource "aws_efs_file_system_policy" "policy" {
  file_system_id = aws_efs_file_system.efs.id
  policy         = data.aws_iam_policy_document.efs.json
}