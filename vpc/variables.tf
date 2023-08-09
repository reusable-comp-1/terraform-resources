

 variable "tags" {
  type        = map(string)
  default     = {
    Name      = "vpc123"
    environment = "test"
}
}

variable "cidr_block" {
  type = string
   default = "10.0.0.0/16"
}
# variable "subnet_name" {
#     type = list(string)
#     #default = ["public", "private"]  
# }



#  variable "azs" {
#    type = list(string)
#  }

#  variable "private_subnets" {
#    type = list(string)
#     default= ["10.0.101.0/24"]
#  }

#  variable "public_subnets" {
#    type = list(string)
#     default= ["10.0.1.0/24"]
#  }



#  variable "environment" {
#     type = string
#   default = "test"


# }
# variable "Name" {
#   type = string
#   default = "vpc123"
# }