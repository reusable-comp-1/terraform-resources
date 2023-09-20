variable "domain_name" {
  description = "The domain name for which Route 53 resources will be created"
  type        = string
}

variable "record_name" {
  description = "The name of the DNS record to create"
  type        = string
}

variable "record_type" {
  description = "The type of the DNS record (e.g., A, CNAME, MX)"
  type        = string
}

variable "record_value" {
  description = "The value of the DNS record (e.g., IP address or domain name)"
  type        = string
}

# Add more variables as needed
