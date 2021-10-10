output "vm_manager" {
    value = "${google_compute_instance.vm_manager.*.network_interface.0.access_config.0.nat_ip}"
}

output "vm_worker" {
    value = "${google_compute_instance.vm_worker.*.network_interface.0.access_config.0.nat_ip}"
}

output "gs_address" {
    value = "https://storage.googleapis.com/${google_storage_bucket.bucket.name}"
}