# provider "google" {
#   credentials = "${file("service-account.json")}"
#   project = var.gcp_project
#   region  = var.gcp_region
#   zone    = var.gcp_zone
# }

resource "google_compute_network" "vpc" {      
  name                    = var.name
  auto_create_subnetworks = var.auto_create_subnetworks

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
   labels= var.labels
   enable_display= var.enable_display
    metadata = {
    sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
    }
    service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "test-880@hallowed-oven-369407.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
  
  confidential_instance_config {
    enable_confidential_compute = var.enable_confidential_vm
  }

   deletion_protection=var.deletion_protection
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

resource "google_compute_resource_policy" "hourly" {
name        = var.instance_schedule_policy.name
#region      = var.region
#project     = var.project
description = "Start and stop instances"

instance_schedule_policy {
  vm_start_schedule {
    schedule = var.vm_start_schedule
  }
  vm_stop_schedule {
    schedule = var.vm_stop_schedule
  }
  time_zone = var.time_zone
}
  
}

resource "google_compute_firewall" "http" {
  name    = "${var.network}-firewall-http"
  network = "${google_compute_network.vpc.name}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["${var.network}-firewall-http"]
  source_ranges = ["0.0.0.0/0"]
}


output "vpc_id" {
  value = "${google_compute_network.vpc.id}"
}
output "subnet_ids" {
  value = "${google_compute_subnetwork.subnets[0].id}"
}