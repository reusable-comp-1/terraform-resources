
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "eu-west-3"
    access_key = "AKIAVAEWCFOHIQAIJJVU"
    secret_key = "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"
}

#resource "aws_instance" "EC2Instance" {
#    ami = "ami-05b5a865c3579bbc4"
#    instance_type = "t2.medium"
#    key_name = "monitoring"
#    availability_zone = "eu-west-3c"
#    tenancy = "default"
#    subnet_id = "subnet-0f54ff2913e1d9f6d"
#    ebs_optimized = false
#    vpc_security_group_ids = [
#        "sg-009303d713ad6473d"
#    ]
#    source_dest_check = true
#    root_block_device {
#        volume_size = 16
#        volume_type = "gp2"
#        delete_on_termination = true
#    }
#    tags = {
#        Name = "Monitoring"
#    }
#}



resource "aws_instance" "EC2Instance" {
  ami                    = var.ami
  instance_type         = var.instance_type
  key_name              = var.key_name
  availability_zone     = var.availability_zone
  tenancy               = var.tenancy
  subnet_id             = var.subnet_id
  ebs_optimized         = var.ebs_optimized
  vpc_security_group_ids = var.vpc_security_group_ids
  source_dest_check     = var.source_dest_check

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = var.root_delete_on_termination
  }

  tags = var.tags
}


#resource "aws_eip" "this" {
#  instance = var.instance_id
#}
