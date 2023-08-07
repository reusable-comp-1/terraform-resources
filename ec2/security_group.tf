resource "aws_security_group" "allow_ssh" {
  name        = var.name
  description = "Allow SSH inbound traffic"
  
  vpc_id      = "${aws_vpc.vpc_demo.id}"

  ingress {
    # SSH Port 22 allowed from any IP
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "aws_security_group_id" {
  value = "${aws_security_group.allow_ssh.id}"
}