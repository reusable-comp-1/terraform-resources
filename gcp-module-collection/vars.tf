variable "subnet_name" {
    type = list(string)
    #default = ["public", "private"]  
}

variable "auto_create_subnetworks" {
    type = bool
    default = false
}
variable "ip_cidr_range" {
    type = list(string)
    #default = [ "10.0.0.0/24", "10.0.1.0/24" ]
}

variable "project" {
description = "Google Project ID."
type        = string
}

variable "name" {
    type = string
    #default = "gcp-network"
  
}

variable "region" {
    type = string
    #default = "us-central1"
  
}

variable "compute_address_name" {
    type = string
    default = "ipv4-address"
}

#variable "instance_subnetwork" {
  
#}
variable "mtu" {
  description = "(Optional) Maximum Transmission Unit in bytes. The minimum value for this field is 1460 and the maximum value is 1500 bytes. Default is '1460'."
  type        = string
  default     = 1460

  validation {
    condition     = var.mtu >= 1460 && var.mtu <= 1500
    error_message = "The mtu expects a value between '1460' and '1500'."
  }
}

variable "routing_mode" {
  description = "(Optional) The network-wide routing mode to use. If set to 'REGIONAL', this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to 'GLOBAL', this network's cloud routers will advertise routes with all subnetworks of this network, across regions. Possible values are 'REGIONAL' and 'GLOBAL'. Default is 'REGIONAL'."
  type        = string
  default     = "REGIONAL"
}
variable "enable_ula_internal_ipv6" {
  description = "(Optional) Enable ULA internal ipv6 on this network. Enabling this feature will assign a /48 from google defined ULA prefix fd20::/20."
  type        = bool
  default     = false
}

variable "internal_ipv6_range" {
  description = "(Optional) When enabling ula internal ipv6, caller optionally can specify the /48 range they want from the google defined ULA prefix fd20::/20. The input must be a valid /48 ULA IPv6 address and must be within the fd20::/20. Operation will fail if the speficied /48 is already in used by another resource. If the field is not speficied, then a /48 range will be randomly allocated from fd20::/20 and returned via this field."
  type        = string
  default     = null
}



variable "gce_ssh_user" {
    type = string
}
variable "gce_ssh_pub_key_file" {
    type = string
}

variable "instance_name" {
    type = string
}

variable "firewall_name" {
    type = string
}

variable "machine_type" {
    type = string
}

variable "protocol" {
    type = string  
}

variable "ports" {
    type = list
}

variable "target_tags" {
    type = list
}

variable "source_ranges" {
    type = list 
}

#S3

variable "bucket_name_set" {
  description = "A set of GCS bucket names..."
  type        = list(string)
}

variable "location" {
    type = string
    default = "us-central1"
  
}

variable "uniform_bucket_level_access" {
  type=bool
  default=true 
}  

variable "storage_class" {
  type= string
  default = "STANDARD"
}

variable "force_destroy" {
  type = bool
  default = true
}

variable "versioning_enabled" {
  type=bool
  default=true
}

variable "public_access_prevention" {
  type=string
  default="enforced"
}




variable "db_instance_name" {
  type        = string
  description = "The name of the Cloud SQL resources"
}

variable "random_instance_name" {
  type        = bool
  description = "Sets random suffix at the end of the Cloud SQL resource name"
  default     = false
}

// required
variable "database_version" {
  description = "The database version to use"
  type        = string
}

// required
# variable "region" {
#   description = "The region of the Cloud SQL resources"
#   type        = string
#   default     = "us-central1"
# }

// Master
variable "tier" {
  description = "The tier for the master instance."
  type        = string
  default     = "db-n1-standard-1"
}

variable "zone" {
  description = "The zone for the master instance, it should be something like: `us-central1-a`, `us-east1-c`."
  type        = string
}

variable "activation_policy" {
  description = "The activation policy for the master instance. Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`."
  type        = string
  default     = "ALWAYS"
}

variable "availability_type" {
  description = "The availability type for the master instance. Can be either `REGIONAL` or `null`."
  type        = string
  default     = "REGIONAL"
}

variable "disk_autoresize" {
  description = "Configuration to increase storage size"
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "The disk size for the master instance"
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "The disk type for the master instance."
  type        = string
  default     = "PD_SSD"
}

variable "pricing_plan" {
  description = "The pricing plan for the master instance."
  type        = string
  default     = "PER_USE"
}

variable "maintenance_window_day" {
  description = "The day of week (1-7) for the master instance maintenance."
  type        = number
  default     = 1
}

variable "maintenance_window_hour" {
  description = "The hour of day (0-23) maintenance window for the master instance maintenance."
  type        = number
  default     = 23
}

variable "maintenance_window_update_track" {
  description = "The update track of maintenance window for the master instance maintenance. Can be either `canary` or `stable`."
  type        = string
  default     = "canary"
}

# variable "database_flags" {
#   description = "List of Cloud SQL flags that are applied to the database server. See [more details](https://cloud.google.com/sql/docs/mysql/flags)"
#   type = list(object({
#     name  = string
#     value = string
#   }))
#   default = []
# }

variable "database_flags" {
  description = "List of Cloud SQL flags that are applied to the database server. See [more details](https://cloud.google.com/sql/docs/mysql/flags)"
  type=map
  # type = list(object({
  #   name  = string
  #   value = string
  # }))
   default = {
    character_set_server = "utf8mb4"
    slow_query_log = "on"
  }
}


variable "user_labels" {
  type        = map(string)
  default     = {}
  description = "The key/value labels for the master instances."
}

variable "backup_configuration" {
  description = "The backup_configuration settings subblock for the database setings"
  type = object({
    binary_log_enabled             = bool
    enabled                        = bool
    start_time                     = string
    location                       = string
    transaction_log_retention_days = string
    retained_backups               = number
    retention_unit                 = string
  })
  default = {
    binary_log_enabled             = false
    enabled                        = false
    start_time                     = null
    location                       = null
    transaction_log_retention_days = null
    retained_backups               = null
    retention_unit                 = null
  }
}

variable "ip_configuration" {
  description = "The ip_configuration settings subblock"
  type = object({
    authorized_networks = list(map(string))
    ipv4_enabled        = bool
    private_network     = string
    require_ssl         = bool
  })
  default = {
    authorized_networks = []
    ipv4_enabled        = true
    private_network     = null
    require_ssl         = null
  }
}

// Read Replicas
variable "read_replicas" {
  description = "List of read replicas to create"
  type = list(object({
    name            = string
    tier            = string
    zone            = string
    disk_type       = string
    disk_autoresize = bool
    disk_size       = string
    user_labels     = map(string)
    database_flags = list(object({
      name  = string
      value = string
    }))
    ip_configuration = object({
      authorized_networks = list(map(string))
      ipv4_enabled        = bool
      private_network     = string
      require_ssl         = bool
    })
  }))
  default = []
}

variable "read_replica_name_suffix" {
  description = "The optional suffix to add to the read instance name"
  type        = string
  default     = ""
}

variable "db_name" {
  description = "The name of the default database to create"
  type        = string
  default     = "default"
}

variable "db_charset" {
  description = "The charset for the default database"
  type        = string
  default     = ""
}

variable "db_collation" {
  description = "The collation for the default database. Example: 'utf8_general_ci'"
  type        = string
  default     = ""
}

variable "additional_databases" {
  description = "A list of databases to be created in your cluster"
  type = list(object({
    name      = string
    charset   = string
    collation = string
  }))
  default = []
}

variable "user_name" {
  description = "The name of the default user"
  type        = string
  default     = "default"
}

variable "user_host" {
  description = "The host for the default user"
  type        = string
  default     = "%"
}

variable "user_password" {
  description = "The password for the default user. If not set, a random one will be generated and available in the generated_user_password output variable."
  type        = string
  default     = ""
}

variable "additional_users" {
  description = "A list of users to be created in your cluster"
  type        = list(map(any))
  default     = []
}

variable "create_timeout" {
  description = "The optional timout that is applied to limit long database creates."
  type        = string
  default     = "10m"
}

variable "update_timeout" {
  description = "The optional timout that is applied to limit long database updates."
  type        = string
  default     = "10m"
}

variable "delete_timeout" {
  description = "The optional timout that is applied to limit long database deletes."
  type        = string
  default     = "10m"
}

variable "encryption_key_name" {
  description = "The full path to the encryption key used for the CMEK disk encryption"
  type        = string
  default     = null
}

variable "module_depends_on" {
  description = "List of modules or resources this module depends on."
  type        = list(any)
  default     = []
}

variable "deletion_protection" {
  description = "Used to block Terraform from deleting a SQL Instance."
  type        = bool
  default     = true
}

variable "read_replica_deletion_protection" {
  description = "Used to block Terraform from deleting replica SQL Instances."
  type        = bool
  default     = false
}

variable "enable_default_db" {
  description = "Enable or disable the creation of the default database"
  type        = bool
  default     = true
}

variable "enable_default_user" {
  description = "Enable or disable the creation of the default user"
  type        = bool
  default     = true
}



