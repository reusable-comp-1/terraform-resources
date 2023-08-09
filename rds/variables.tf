
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

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = string
  default     = "Custom-VPC"
}


variable "allocated_storage"{
    type=string
    default= 20
}

variable "storage_type" {
    type=string
    default="gp2"
}

variable "engine" {
    type=string
    default="mysql"
}

variable "engine_version" {
    type=string
    default="5.7"
}

variable "instance_class" {
    type=string
    default="db.t2.micro"
}

variable "db_name" {
    type=string
    default="MySQL_db"
}

variable "username" {
    type=string
    default="root"
}

variable "password" {
    type=string
    default="foobarbaz"
}



variable "db_parameter_group_name"{
    type=string
    default="rds-mysql"

}

variable "family" {
    type=string
    default="mysql5.7"
}

 variable "name" {
  type=string
  default="db-subnets"
 }