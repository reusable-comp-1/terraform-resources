resource "aws_eip" "elastic_ip" {
  instance = null  # Associate with instance using instance_id, if needed
  tags     = var.tags
}

