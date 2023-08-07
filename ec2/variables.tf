# variable "tag_ec2" {
#   type = list(string)
#   default = ["ec21a","ec21b"]
# }

variable "ssh_key_pair" {
  type=string
  default="my-ssh-key"
}

variable "ami" {       # Creating a Variable for ami
  type = string
  default="ami-074dc0a6f6c764218"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

# variable "network_interface_id" {
#   type = string
#   default = "network_id_from_aws"
# }




# variable "ami" {
#   type =string
#   default ="ami-090fa75af13c156b4"
# }
# variable "ami_id" {
#   type =map
#   default = {
#     us-east-1    = "ami-035b3c7efe6d061d5"
#     #eu-west-2    = "ami-132b3c7efe6sdfdsfd"
#     #eu-central-1 = "ami-9787h5h6nsn75gd33"
#   }
# }



# variable "Name" {
#   type=string
#   default= "Ec2-with-VPC"
# }

# variable "instance_name" {
#   type=string
#   default="test"
# }
variable "tags" {
  type=map(string)
}

variable "subnet_id" { 
}
variable "vpc_id" {

}



variable "key_name" {
  type=string
}
variable "availability_zone" {
  type = string
  default = "ap-south-1a"
  
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "ssh_key_name" {
  type    = string
  default = "ec2-demo"
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}
variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_classiclink" {
  description = "Should be true to enable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type        = bool
  default     = false
}






# variable "tags" {
#   description = "A map of tags to add to all resources"
#   type        = string
#   default     = "Vpc-custom-demo"
# }

variable "volume_size" {
  type=number
  #default = 20
}

variable "volume_type" {
  type= string
  #default= "gp2"
}

variable "device_name" {
  type=string
  default= "/dev/xvdh"
}

variable "name" {
  type=string
  default = "allow_ssh"
}

variable "cidr_block" {
  type = string
  default = "10.0.1.0/24"
}

variable "EC2_root_volume_size" {
  type    = string
  #default = "30"
  description = "The volume size for the root volume in GiB"
}
variable "EC2_root_volume_type" {
  type    = string
  #default = "gp2"
  description = "The type of data storage: standard, gp2, io1"
}
variable "EC2_ROOT_VOLUME_DELETE_ON_TERMINATION" {
  default = true
  description = "Delete the root volume on instance termination."
}