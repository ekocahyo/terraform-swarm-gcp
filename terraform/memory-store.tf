resource "google_redis_instance" "cache" {
    name               = "${var.project_prefix_name}"
    tier               = "${var.redis_tier}"
    memory_size_gb     = var.redis_size
    location_id        = "${var.project_zone}"
    redis_version      = "${var.redis_version}"
    display_name       = "${var.project_prefix_name}"
    auth_enabled       = true
}