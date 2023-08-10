variable "bucket_name_set" {
  description = "A set of GCS bucket names..."
  type        = list(string)
}

variable "region" {
  type = string
  default = "asia-south1"
}

variable "project_id" {
description = "Google Project ID."
type        = string
}

variable "storage_class" {
  type= string
  default = "STANDARD"
}

variable "force_destroy" {
  type = bool
  default = false
}

variable "public_access_prevention" {
  type=string
  default="enforced"
}

variable "versioning_enabled" {
  type=bool
  default=true
}

variable "uniform_bucket_level_access" {
  type=bool
  default=true 
}  
  
  
  # variable "gcp_credentials" {
#   type = string
#   sensitive = true
#   description = "Google Cloud service account credentials"
# }