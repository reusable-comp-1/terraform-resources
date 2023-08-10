resource "google_compute_network" "gcp-vpc" {
  name                    = var.name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public-subnet" {
   name          = "${var.public-subnet}"
   ip_cidr_range = "${var.vpc-cidr}"
   region        = "${var.region}"
   network       = "${google_compute_network.gcp-vpc.id}"
}

resource "google_compute_subnetwork" "private-subnet" {
   name          = "${var.private-subnet}"
   ip_cidr_range = "${var.vpc_cidr}"
   region        = "${var.region}"
   network       = "${google_compute_network.gcp-vpc.id}"
}

resource "google_compute_router" "router" {
  name    = "my-router"
  #region  = google_compute_subnetwork.private-subnet.region
  network = google_compute_network.gcp-vpc.id
  bgp {
    asn            = 64514
    advertise_mode = "CUSTOM"
  }
}

# resource "google_compute_router_nat" "nat" {
#   name                               = "my-router-nat"
#   router                             = google_compute_router.router.name
#   region                             = google_compute_router.router.region
#   nat_ip_allocate_option             = "AUTO_ONLY"
#   source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
#   subnetwork {
#     name                    = "private"
#     source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
#   }
# }


# resource "google_compute_subnetwork" "subnet" {
#    for_each      = toset(var.subnet_names_set)
#    name          = each.value    
#   #name          = "${var.subnet_names}-subnet"
#   ip_cidr_range = var.subnet_cidr[0]
#   network       = google_compute_network.main.id
#   region        = var.region
  
#   depends_on = [google_compute_network.main]
# }



