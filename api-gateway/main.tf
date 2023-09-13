terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}


resource "aws_docdb_cluster" "DocDBDBCluster" {
    availability_zones = var.availability_zones
    backup_retention_period = var.backup_retention_period
    cluster_identifier = var.cluster_identifier
    db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
    engine_version = var.engine_version
    port = var.port
    master_username = var.master_username
    master_password = var.master_password
    preferred_backup_window = var.preferred_backup_window
    preferred_maintenance_window = var.preferred_maintenance_window
    vpc_security_group_ids = var.vpc_security_group_ids
    storage_encrypted = var.storage_encrypted
    kms_key_id = var.kms_key_id
}

