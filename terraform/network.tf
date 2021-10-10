resource "google_compute_network" "swarm" {
  name = "${var.project_prefix_name}-swarm"
}

resource "google_compute_firewall" "swarm" {
  name    = "${var.project_prefix_name}-swarm"
  network = "${google_compute_network.swarm.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = var.fw_allow_tcp_docker
  }

  allow {
    protocol = "udp"
    ports    = var.fw_allow_udp_docker
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "secret" {
  name    = "${var.project_prefix_name}-secret"
  network = "${google_compute_network.swarm.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = var.fw_allow_tcp_secret
  }

  allow {
    protocol = "udp"
    ports    = var.fw_allow_udp_secret
  }

  source_ranges = "${var.fw_ip_whitelist}"
}