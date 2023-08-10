resource "google_compute_network" "vpc" {
  name                    = var.name
  auto_create_subnetworks = var.auto_create_subnetworks
   mtu                             = var.mtu
 enable_ula_internal_ipv6        = var.enable_ula_internal_ipv6
 internal_ipv6_range             = var.internal_ipv6_range
 routing_mode                    = var.routing_mode


}

resource "google_compute_subnetwork" "subnets" {
 count = length(var.subnet_name)
 name = element(var.subnet_name, count.index)
 ip_cidr_range = element(var.ip_cidr_range, count.index)
 network = "${google_compute_network.vpc.id}"
} 

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type 
  #subnetwork =var.instance_subnetwork
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-focal-v20210415"
    }
  }

  network_interface {
       
    #subnetwork = "${google_compute_subnetwork.subnets[0].self_link}"
    network = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnets[0].name
     
    access_config {
       
       #nat_ip = "${google_compute_subnetwork.subnets[0].id}"
      }
  }

metadata = {
  sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }

tags = ["ssh-server"]

}


resource "google_compute_firewall" "ssh-server" {
  name    = var.firewall_name 
  network = google_compute_network.vpc.name

  allow {
    protocol = var.protocol
    ports    = var.ports
  }

  // Allow traffic from everywhere to instances with an ssh-server tag
  source_ranges = var.source_ranges
  target_tags   = var.target_tags
}

resource "google_storage_bucket" "cloud_storage_buckets" {
  #project       = charming-layout-356109
  
  for_each      = toset(var.bucket_name_set)
  name          = each.value     # note: each.key and each.value are the same for a set
  #project       = var.project_id
  location      = var.location
  storage_class = var.storage_class
  force_destroy = var.force_destroy
  uniform_bucket_level_access = true
  public_access_prevention = var.public_access_prevention #"enforced"
  versioning {
      enabled = var.versioning_enabled 
    }



}


locals {
  master_instance_name = var.random_instance_name ? "${var.db_instance_name}-${random_id.suffix[0].hex}" : var.db_instance_name

  default_user_host        = "%"
  ip_configuration_enabled = length(keys(var.ip_configuration)) > 0 ? true : false

  ip_configurations = {
    enabled  = var.ip_configuration
    disabled = {}
  }

  databases = { for db in var.additional_databases : db.name => db }
  users     = { for u in var.additional_users : u.name => u }

  // HA method using REGIONAL availability_type requires binary logs to be enabled
  binary_log_enabled = var.availability_type == "REGIONAL" ? true : lookup(var.backup_configuration, "binary_log_enabled", null)
  backups_enabled    = var.availability_type == "REGIONAL" ? true : lookup(var.backup_configuration, "enabled", null)

  retained_backups = lookup(var.backup_configuration, "retained_backups", null)
  retention_unit   = lookup(var.backup_configuration, "retention_unit", null)
}

resource "random_id" "suffix" {
  count = var.random_instance_name ? 1 : 0

  byte_length = 4
}


# resource "google_compute_network" "private_network" {
#   provider = "google-beta"
#   project             = var.project_id

#   name       = "sql-network"
# }

resource "google_compute_global_address" "private_ip_address" {
  project             = var.project
  provider = "google-beta"

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type = "INTERNAL"
  prefix_length = 16
  network       = "${google_compute_network.vpc.self_link}"
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = "google-beta"

  network       = "${google_compute_network.vpc.self_link}"
  service       = "servicenetworking.googleapis.com"
  reserved_peering_ranges = ["${google_compute_global_address.private_ip_address.name}"]
}


resource "google_sql_database_instance" "default" {
  provider            = google-beta
  project             = var.project
  name                = local.master_instance_name
  database_version    = var.database_version
  region              = var.region
  encryption_key_name = var.encryption_key_name
  deletion_protection = var.deletion_protection

  settings {
    tier              = var.tier
    activation_policy = var.activation_policy
    availability_type = var.availability_type
    dynamic "backup_configuration" {
      for_each = [var.backup_configuration]
      content {
        binary_log_enabled             = local.binary_log_enabled
        enabled                        = local.backups_enabled
        start_time                     = lookup(backup_configuration.value, "start_time", null)
        location                       = lookup(backup_configuration.value, "location", null)
        transaction_log_retention_days = lookup(backup_configuration.value, "transaction_log_retention_days", null)
        point_in_time_recovery_enabled = lookup(backup_configuration.value, "point_in_time_recovery_enabled", false)
        dynamic "backup_retention_settings" {
          for_each = local.retained_backups != null || local.retention_unit != null ? [var.backup_configuration] : []
          content {
            retained_backups = local.retained_backups
            retention_unit   = local.retention_unit
          }
        }
      }
    }
    dynamic "ip_configuration" {
      for_each = [local.ip_configurations[local.ip_configuration_enabled ? "enabled" : "disabled"]]
      content {
        ipv4_enabled    = lookup(ip_configuration.value, "ipv4_enabled", null)
        private_network = "${google_compute_network.vpc.self_link}"
        require_ssl     = lookup(ip_configuration.value, "require_ssl", null)

        dynamic "authorized_networks" {
          for_each = lookup(ip_configuration.value, "authorized_networks", [])
          content {
            expiration_time = lookup(authorized_networks.value, "expiration_time", null)
            name            = lookup(authorized_networks.value, "name", null)
            value           = lookup(authorized_networks.value, "value", null)
          }
        }
      }
    }

    disk_autoresize = var.disk_autoresize

    disk_size    = var.disk_size
    disk_type    = var.disk_type
    pricing_plan = var.pricing_plan
    user_labels  = var.user_labels


    dynamic "database_flags" {
      for_each = var.database_flags
      iterator = flag
       content {
        name = flag.key
        value = flag.value
      }
      # content {
      #   name  = lookup(database_flags.value, "name", null)
      #   value = lookup(database_flags.value, "value", null)
      # }
    }

    location_preference {
      zone = var.zone
    }

    maintenance_window {
      day          = var.maintenance_window_day
      hour         = var.maintenance_window_hour
      update_track = var.maintenance_window_update_track
    }
  }

  lifecycle {
    ignore_changes = [
      settings[0].disk_size
    ]
  }

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }

  depends_on = [null_resource.module_depends_on, google_service_networking_connection.private_vpc_connection]
}

resource "google_sql_database" "default" {
 
  count      = var.enable_default_db ? 1 : 0
  name       = var.db_name
  project    = var.project
  instance   = google_sql_database_instance.default.name
  charset    = var.db_charset
  collation  = var.db_collation
  depends_on = [null_resource.module_depends_on, google_sql_database_instance.default]
}

resource "google_sql_database" "additional_databases" {
  
  for_each   = local.databases
  project    = var.project
  name       = each.value.name
  charset    = lookup(each.value, "charset", null)
  collation  = lookup(each.value, "collation", null)
  instance   = google_sql_database_instance.default.name
  depends_on = [null_resource.module_depends_on, google_sql_database_instance.default]
}

resource "random_id" "user-password" {
  
  keepers = {
    name = google_sql_database_instance.default.name
  }

  byte_length = 8
  depends_on  = [null_resource.module_depends_on, google_sql_database_instance.default]
}

resource "random_id" "additional_passwords" {
  
  for_each = local.users
  keepers = {
    name = google_sql_database_instance.default.name
  }

  byte_length = 8
  depends_on  = [null_resource.module_depends_on, google_sql_database_instance.default]
}

resource "google_sql_user" "default" {
  
  count      = var.enable_default_user ? 1 : 0
  name       = var.user_name
  project    = var.project
  instance   = google_sql_database_instance.default.name
  host       = var.user_host
  password   = var.user_password == "" ? random_id.user-password.hex : var.user_password
  depends_on = [null_resource.module_depends_on, google_sql_database_instance.default]
}

resource "google_sql_user" "additional_users" {
  
  for_each   = local.users
  project    = var.project
  name       = each.value.name
  password   = lookup(each.value, "password", random_id.user-password.hex)
  host       = lookup(each.value, "host", var.user_host)
  instance   = google_sql_database_instance.default.name
  type       = lookup(each.value, "type", "BUILT_IN")
  depends_on = [null_resource.module_depends_on, google_sql_database_instance.default]
}

resource "null_resource" "module_depends_on" {
  
  triggers = {
    value = length(var.module_depends_on)
  }
}


output "vpc_id" {
  value = "${google_compute_network.vpc.id}"
}
output "subnet_ids" {
  value = "${google_compute_subnetwork.subnets[0].id}"
}