resource "aws_db_parameter_group" "default" {
  name   = var.db_parameter_group_name 
  family = var.family 

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = var.name 
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  tags = {
    Name = "DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated_storage 
  storage_type         = var.storage_type
  engine               = var.engine 
  engine_version       = var.engine_version 
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  skip_final_snapshot     = true
  #parameter_group_name = var.db_parameter_group_name 
  db_subnet_group_name=aws_db_subnet_group.default.name
  vpc_security_group_ids=[aws_security_group.db.id]
  availability_zone=aws_subnet.private_1.availability_zone
  vpc_id = var.vpc_id
}

output "end_point" {
  value = aws_db_instance.default.endpoint
}
