provider "google" {
    credentials = "${file("${var.project_credentials}")}"
    project = "${var.project_name}"
    region = "${var.project_region}"
}