resource "google_compute_address" "static" {
  name = var.compute_address_name 
}

resource "google_compute_instance" "vm_instance" {
  name         = var.name
  machine_type = var.machine_type 
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-focal-v20210415"
    }
  }
   labels       = var.labels
  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
      nat_ip = google_compute_address.static.address
      }
  }
  #enable_attached_disk =var.enable_attached_disk


metadata = {
  sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }
   deletion_protection = var.deletion_protection
  #resource_policies   = var.resource_policies

tags = ["ssh-server"]

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

resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = var. auto_create_subnetworks
}

resource "google_compute_firewall" "ssh-server" {
  name    = var.firewall_name 
  network = google_compute_network.vpc_network.name

  allow {
    protocol = var.protocol
    ports    = var.ports
  }



  // Allow traffic from everywhere to instances with an ssh-server tag
  source_ranges = var.source_ranges
  target_tags   = var.target_tags
}

resource "google_compute_firewall" "http" {
  name    = "${var.network}-firewall-http"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["${var.network}-firewall-http"]
  source_ranges = ["0.0.0.0/0"]
}
