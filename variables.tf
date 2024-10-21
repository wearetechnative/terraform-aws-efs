variable "name" {
  type = string
  description = "name of the environment"
}

variable "kms_key_id" {
  type = string
  description = "The ARN for the KMS encryption key."  
}

variable "efs_performance_mode" {
  type = string
  description = "The file system performance mode. Can be either \"generalPurpose\" or \"maxIO\""
}

variable "protection" {
  type = string
  description = "Indicates whether replication overwrite protection is enabled. Valid values: ENABLED or DISABLE"
}

