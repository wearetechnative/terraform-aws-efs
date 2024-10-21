variable "name" {
  type = string
  description = "name of the environment"
}

variable "kms_key_id" {
  type = string
  description = "Id of the kms key for encryption"  
}

variable "efs_performance_mode" {
  type = string
  description = "The file system performance mode. Can be either \"generalPurpose\" or \"maxIO\""
}