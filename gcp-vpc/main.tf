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





# resource "aws_subnet" "main-subnet" {
#   for_each = var.prefix
 
#   availability_zone_id = each.value["az"]
#   cidr_block = each.value["cidr"]
#   vpc_id     = aws_vpc.main-vpc.id

#   tags = {
#     Name = "${var.basename}-subnet-${each.key}"
#   }
# }
