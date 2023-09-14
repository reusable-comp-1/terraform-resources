variable "availability_zones" {
    type    = list(string)
#    default = var.availability_zones
}

variable "backup_retention_period" {
    type    = number
#    default = var.backup_retention_period
}

variable "cluster_identifier" {
    type    = string
#    default = var.cluster_identifier
}

variable "db_cluster_parameter_group_name" {
    type    = string
#    default = var.db_cluster_parameter_group_name
}

variable "engine_version" {
    type    = string
#    default = var.engine_version
}

variable "port" {
    type    = number
#    default = var.port
}

variable "master_username" {
    type    = string
#    default = var.master_username
}

variable "master_password" {
    type    = string
#    default = var.master_password
}

variable "preferred_backup_window" {
    type    = string
#    default = "00:00-00:30"
}

variable "preferred_maintenance_window" {
    type    = string
#    default = var.maintenance_window
}

variable "vpc_security_group_ids" {
    type    = list(string)
#    default = var.vpc_security_group_ids
}

variable "storage_encrypted" {
    type    = bool
#    default = var.storage_encrypted
}

variable "kms_key_id" {
    type    = string
#    default = var.kms_key_id
}
