resource "google_service_account" "dataproc-svc" {
  project      = "myproject-45-389614"
  account_id   = "dataproc-svc"
  display_name = "Service Account - dataproc"
}

resource "google_project_iam_member" "svc-access" {
  project = "myproject-45-389614"
  role    = "roles/dataproc.worker"
  member  = "serviceAccount:${google_service_account.dataproc-svc.email}"
}

resource "google_storage_bucket" "dataproc-bucket" {
  project                     = "myproject-45-389614"
  name                        = "terraform-dataproc-config"
  uniform_bucket_level_access = true
  location                    = "us-central1"
}

resource "google_storage_bucket_iam_member" "dataproc-member" {
  bucket = google_storage_bucket.dataproc-bucket.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.dataproc-svc.email}"
}
