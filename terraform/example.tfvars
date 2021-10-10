project_credentials = "credentials/key.json"
project_name = "myproject" # lihat dengan perintah "gcloud projects list"
project_region = "asia-southeast2"
project_zone = "asia-southeast2-a"
project_prefix_name = "projec-production"

vm_manager_count = 1
vm_worker_count = 1
vm_type = "e2-small"
vm_os_name = "centos-cloud/centos-7"
vm_disk_size = 50
vm_user_ssh = {
        gloingdev1 = "credentials/user1.pub",
        gloingdev2 = "credentials/user2.pub"
    }

fw_allow_tcp_docker = ["80","443"]
fw_allow_udp_docker = ["7946","4789"]
fw_allow_tcp_secret = ["22"]
fw_allow_udp_secret = []
fw_ip_whitelist = ["xxx.xxx.xxx.xxx","xxx.xxx.xxx.xxx"]

db_tier = "db-g1-small"
db_deletion_protection = false
db_version = "MYSQL_8_0"
db_disk_size = 10
db_root_pass = "Password@db"
db_user_apps = "username"
db_pass_apps = "password"