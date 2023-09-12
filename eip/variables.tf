variable "name" {
  description = "The name of the Elastic IP"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Elastic IP"
  type        = map(string)
}
