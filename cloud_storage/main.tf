resource "google_storage_bucket" "cloud_storage_buckets" {
  #project       = charming-layout-356109

  for_each      = toset(var.bucket_name_set)
  name          = each.value     # note: each.key and each.value are the same for a set
  project       = var.project_id
  location      = var.region
  storage_class = var.storage_class
  force_destroy = var.force_destroy
  public_access_prevention = var.public_access_prevention #"enforced"
  uniform_bucket_level_access = var.uniform_bucket_level_access #true
  versioning {
      enabled = var.versioning_enabled 
    }

  #the versioning argument is a block (not a map),thus including the '=' confuses Terraform. 
  #   retention_policy {
  # retention_period = 86400
  #}
  #encryption = default_kms_key_name
}

# resource "google_storage_bucket" "with-google-managed-encryption-key" {
#   name     = "gcp-managed-encryption-key-bucket-${data.google_project.current.number}"
#   #location = "EU"
# }

  #  encryption {
  #   default_kms_key_name = Google-managed encryption key
  # }




#Note that object versioning and retention policies cannot be used together.
#retention_policy does not delete the objects automatically.it is only set as to ensure that the objects don't get deleted, overwritten, or archived within the period given

