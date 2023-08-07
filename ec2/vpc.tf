# resource "aws_vpc" "vpc_demo" {
#   cidr_block                       = var.cidr
#   instance_tenancy                 = var.instance_tenancy
#   enable_dns_hostnames             = var.enable_dns_hostnames
#   enable_dns_support               = var.enable_dns_support
#   enable_classiclink               = var.enable_classiclink
  

#   tags = {
#       Name = "test-vpc"
#     }
# }

# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.vpc_demo.id

#   tags = {
#     Name = "internet-gateway-demo"
#   }
# }

# resource "aws_subnet" "public_subnet" {
#   vpc_id     = aws_vpc.vpc_demo.id
#   map_public_ip_on_launch = true
#   cidr_block = var.cidr_block
#   availability_zone = var.availability_zone

#   tags = {
#     Name = "public_1-demo"
#   }
# }

# resource "aws_route_table" "route-public" {
#   vpc_id = aws_vpc.vpc_demo.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }

#   tags = {
#     Name = "public-route-table-demo"
#   }
# }

# resource "aws_route_table_association" "public_1" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.route-public.id
# }

# # output "vpc_id" {
# #   value = "${aws_vpc.vpc_demo.id}"
# # }

# # output "subnet_id" {
# #   value = "${aws_subnet.public_subnet.id}"
# # }