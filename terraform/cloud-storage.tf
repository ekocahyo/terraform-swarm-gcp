resource "google_storage_bucket_access_control" "public_rule" {
    bucket = google_storage_bucket.bucket.name
    role   = "READER"
    entity = "allUsers"
}

resource "google_storage_bucket" "bucket" {
    name          = "${var.project_prefix_name}"
    storage_class = "REGIONAL"
    location      = "${var.project_region}"
    force_destroy = true
    uniform_bucket_level_access = false
}