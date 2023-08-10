variable "name" {
    type= string
    default = "demo-vpc"
}

variable "public-subnet" {
  type = string
  default = "public"
}

variable "private-subnet" {
  type = string
  default = "private"
}


variable "vpc-cidr" {
    type = string
  default = "10.0.0.0/24"

}

variable "vpc_cidr" {
    type = string
    default = "10.0.1.0/24"
  
}

variable "region" {
  type=string
  default = "asia-south1"  
}