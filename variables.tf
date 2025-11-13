variable "name" {
  type        = string
  description = "name of the environment (resource will get this name in the console)"
}

variable "token" {
  type        = string
  default     = null
  description = "A unique name used as reference when creating the Elastic File System to ensure idempotent file system creation. "
}

variable "kms_key_id" {
  type        = string
  description = "The ARN of the KMS encryption key."
}

variable "efs_performance_mode" {
  type        = string
  description = "The file system performance mode. Can be either \"generalPurpose\" or \"maxIO\""
}

variable "protection" {
  type        = string
  description = "Indicates whether replication overwrite protection is enabled. Valid values: ENABLED or DISABLE"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs (one per AZ) where mount targets should be created."
}
