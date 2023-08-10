variable "gce_ssh_user" {
    type = string
}
variable "gce_ssh_pub_key_file" {
    type = string
    default="./my-ssh-key.pub"
}
variable "gcp_project" {
    type = string
}
variable "gcp_region" {
    type = string
}
variable "gcp_zone" {
    type = string
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
    default=false
}

variable "name" {
    type = string
}

variable "compute_address_name" {
    type = string
}

variable "network" {
    type=string
    default="test"
}

variable "firewall_name" {
    type = string
}

variable "machine_type" {
    type = string
}

variable "auto_create_subnetworks" {
    type = bool   
}

variable "network_name" {
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

variable "labels" {
  type = map(string)
  default = {
    owner       = "demouser"
    environment = "demo"
    app         = "demo"
    ttl         = "24"
  }
}



