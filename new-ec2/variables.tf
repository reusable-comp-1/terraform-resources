variable "ami" {
  description = "AMI ID"
}

variable "instance_type" {
  description = "EC2 instance type"
}

variable "key_name" {
  description = "Key pair name"
}

variable "availability_zone" {
  description = "Availability Zone"
}

variable "tenancy" {
  description = "Tenancy"
}

variable "subnet_id" {
  description = "Subnet ID"
}

variable "ebs_optimized" {
  description = "EBS optimized"
}

variable "vpc_security_group_ids" {
  description = "VPC security group IDs"
}

variable "source_dest_check" {
  description = "Source/destination check"
}

variable "root_volume_size" {
  description = "Root volume size"
}

variable "root_volume_type" {
  description = "Root volume type"
}

variable "root_delete_on_termination" {
  description = "Root volume delete on termination"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
}

