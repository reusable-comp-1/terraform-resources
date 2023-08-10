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

variable "enable_display"{
    type=bool
    default=false
}

variable "service_account_email" {
    type = string
        default="test-880@hallowed-oven-369407.iam.gserviceaccount.com"
}

#     type=map(string)
#     default= {
#         email  = "test-880@hallowed-oven-369407.iam.gserviceaccount.com"
#        scopes = ["cloud-platform"]
#   }
# }

variable "enable_confidential_vm" {
  default     = false
  description = "Whether to enable the Confidential VM configuration on the instance. Note that the instance image must support Confidential VMs. See https://cloud.google.com/compute/docs/images"
}
variable "name" {
    type = string
    #default = "gcp-network"
  
}

# variable "region" {
#     type = string
#     #default = "us-central1"
  
# }

variable "compute_address_name" {
    type = string
    default = "ipv4-address"
}

#variable "instance_subnetwork" {
variable "network" {
    type=string
    default="test"
}  

variable "vm_start_schedule" {
    type=string
    default="30 07 * * *"
}       

variable "vm_stop_schedule" {
    type=string
    default="00 18 * * *"
}

variable "time_zone" {
    type=string
    default="GMT"
}               

variable "enable_attached_disk" {
    type=bool

}
variable "instance_schedule_policy" {
    type=map(string)
default = {
name                      = "start-stop"
vm_start_schedule         = "30 07 * * *"
vm_stop_schedule          = "00 18 * * *"
time_zone                 = "GMT"
}
}

variable "deletion_protection" {
    type=bool
    default=true
}


variable "gce_ssh_user" {
    type = string
    default="test"
}
variable "gce_ssh_pub_key_file" {
    type = string
    default="./my-ssh-key"
}

variable "instance_name" {
    type = string
}

variable "firewall_name" {
    type = string
    default = "allow-ssh-terraform"
    
}

variable "machine_type" {
    type = string
}


variable "protocol" {
    type = string
    default = "tcp"
}

variable "ports" {
    type = list
    default = ["22","80"]
}

variable "target_tags" {
    type = list
    default = ["ssh-server"]
}

variable "source_ranges" {
    type = list 
    default = ["0.0.0.0/0" ]
}




# variable "gce_ssh_pub_key_file" {
#     type = string
#     default="./my-ssh-key"
# }
variable "gcp_project" {
    type = string
}
variable "gcp_region" {
    type = string
}
variable "gcp_zone" {
    type = string
}

variable "labels" {
  type = map(string)
  default = {
    owner       = "demouser"
    environment = "demo"
    app         = "demo"
    ttl         = "24"
  }
}