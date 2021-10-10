resource "google_compute_instance" "vm_manager" {
    count        = "${var.vm_manager_count}"
    name         = "${var.project_prefix_name}-manager-${count.index + 1}"
    zone         = "${var.project_zone}"
    machine_type = "${var.vm_type}"

    boot_disk {
        initialize_params {
            image = "${var.vm_os_name}"
            size = "${var.vm_disk_size}"
        }
    }

    network_interface {
        network       = google_compute_network.swarm.name
        access_config {}
    }

    metadata = {
        ssh-keys = join("\n", [for user, key in var.vm_user_ssh : "${user}:${file(key)}"])
    }
}

resource "google_compute_instance" "vm_worker" {
    count        = "${var.vm_worker_count}"
    name         = "${var.project_prefix_name}-worker-${count.index + 1}"
    zone         = "${var.project_zone}"
    machine_type = "${var.vm_type}"

    boot_disk {
        initialize_params {
            image = "${var.vm_os_name}"
            size = "${var.vm_disk_size}"
        }
    }

    network_interface {
        network       = google_compute_network.swarm.name
        access_config {}
    }

    metadata = {
        ssh-keys = join("\n", [for user, key in var.vm_user_ssh : "${user}:${file(key)}"])
    }
}