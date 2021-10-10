data "template_file" "inventory" {
    template = "${file("template-inventory.tpl")}"

    depends_on = [
        google_compute_instance.vm_manager,
        google_compute_instance.vm_worker,
    ]

    vars = {
        vm_manager = "${join("\n", google_compute_instance.vm_manager.*.network_interface.0.access_config.0.nat_ip)}"
        vm_worker = "${join("\n", google_compute_instance.vm_worker.*.network_interface.0.access_config.0.nat_ip)}"
    }
}

resource "null_resource" "cmd" {
    triggers = {
        template_rendered = "${data.template_file.inventory.rendered}"
    }

    provisioner "local-exec" {
        command = "echo '${data.template_file.inventory.rendered}' > ../ansible/inventory-${var.project_prefix_name}"
    }
}