resource "aws_instance" "test-ec2" {
  ami = var.ami
  instance_type ="t2.micro"
  key_name               = var.key_name #"my-ssh-key"
  availability_zone = var.availability_zone
  subnet_id     = var.subnet_id #"${aws_subnet.public_subnet.id}"
  vpc_security_group_ids=  [aws_security_group.allow_ssh.id]
   root_block_device  {
    volume_size           = "${var.EC2_root_volume_size}"
    volume_type           = "${var.EC2_root_volume_type}"
    delete_on_termination = "${var.EC2_ROOT_VOLUME_DELETE_ON_TERMINATION}"
  }
   tags = var.tags  
  
}
  

resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = var.availability_zone 
  size              = var.volume_size 
  type              = var.volume_type 

  tags = {
    Name = "ebs-volume-terraform-demo"
  }
}

resource "aws_volume_attachment" "ebc_volume_attachment" {
  device_name = var.device_name 
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.test-ec2.id
}

resource "aws_vpc" "vpc_demo" {
  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink
  

  tags = {
      Name = "test-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc_demo.id}"

  tags = {
    Name = "internet-gateway-demo"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = var.vpc_id
  #"${aws_vpc.vpc_demo.id}"
  map_public_ip_on_launch = true
  cidr_block = var.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "public_1-demo"
  }
}

resource "aws_route_table" "route-public" {
  vpc_id ="${aws_vpc.vpc_demo.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table-demo"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route-public.id
}


output "vpc_id" {
  value = "${aws_vpc.vpc_demo.id}"
}

output "subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}


