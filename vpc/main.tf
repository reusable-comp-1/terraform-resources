resource "aws_vpc" "vpc" {
  
  
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  Name= "test-vpc"
  
}

