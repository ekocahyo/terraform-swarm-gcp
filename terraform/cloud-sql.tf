resource "google_sql_database_instance" "mysql" {
    name = "${var.project_prefix_name}"
    database_version = "${var.db_version}"
    region = "${var.project_region}"
    settings {
        tier = "${var.db_tier}"
        disk_size = var.db_disk_size
        ip_configuration {

            dynamic "authorized_networks" {
                for_each = google_compute_instance.vm_manager
                iterator = manager

                content {
                    name  = manager.value.name
                    value = manager.value.network_interface.0.access_config.0.nat_ip
                }
            }
            dynamic "authorized_networks" {
                for_each = google_compute_instance.vm_worker
                iterator = worker

                content {
                    name  = worker.value.name
                    value = worker.value.network_interface.0.access_config.0.nat_ip
                }
            }
            dynamic "authorized_networks" {
                for_each = var.fw_ip_whitelist
                iterator = secret

                content {
                    name  = "secret-${secret.key}"
                    value = secret.value
                }
            }
        }
    }
}

resource "google_sql_database" "database" {
    name = "${var.db_name}"
    instance = "${google_sql_database_instance.mysql.name}"
    charset = "utf8"
    collation = "utf8_general_ci"
}

resource "google_sql_user" "root" {
    name = "root"
    instance = "${google_sql_database_instance.mysql.name}"
    host = "%"
    password = "${var.db_root_pass}"
}

resource "google_sql_user" "user" {
  name     = "${var.db_user_apps}"
  instance = "${google_sql_database_instance.mysql.name}"
  host     = "%"
  password = "${var.db_pass_apps}"
}