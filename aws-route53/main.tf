resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "main" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.record_name
  type    = var.record_type
  ttl     = 300
  records = [var.record_value]
}

# Add more Route 53 resources as needed
