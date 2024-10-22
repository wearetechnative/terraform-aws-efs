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
  security_groups = [aws_security_group.efs.id]
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

data "aws_subnet" "efs" {
  id = var.subnet_id
}

resource "aws_security_group" "efs" {
  vpc_id = data.aws_subnet.efs.vpc_id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = var.name
  }
}
