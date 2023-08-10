resource "google_container_registry" "my-registry" {
  project  = var.project 
  location = var.location            #"EU"
}

resource "google_storage_bucket_iam_member" "viewer" {
  bucket = google_container_registry.my-registry.id
  role = var.role         #"roles/storage.objectViewer"
  member =var.member    #"user:jane@example.com"
}