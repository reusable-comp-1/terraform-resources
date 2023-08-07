variable "ecr_repository_names" {
  description = "Name to be used on all resources as prefix"
  type = list(string)
  default = ["indium-test-repo1", "indium-test-repo2"]
}

# variable "enable_ecr_repository" {
#   description = "Enable ecr repo creating"
#   default     = true
# }

variable "encryption_configuration" {
  type = object({
    encryption_type = string
    kms_key         = any
  })
  description = "ECR encryption configuration"
  default     = null
}


variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`."
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  type = string
  default = true
} 