############################## Project ##############################
variable "project_credentials" {
    description = "Lokasi file credential GCP yang Anda dapat dari IAM"
    type = string
}

variable "project_name" {
    description = "Pilih code project untuk deploy service"
    type = string
}

variable "project_region" {
  description = "Pilih region untuk project"
  type = string
  default = "asia-southeast2"
}

variable "project_zone" {
  description = "Pilih zone untuk project"
  type = string
  default = "asia-southeast2-a"
}

variable "project_prefix_name" {
  description = "Untuk Prefix penamaan semua module"
  type = string
}


############################## Compute Engine ##############################
variable "vm_manager_count" {
  description = "Jumlah node yang ingin di install untuk manager docker swarm"
  type = number
  default = 1
}

variable "vm_worker_count" {
  description = "Jumlah node yang ingin di install untuk worker docker swarm"
  type = number
  default = 0
}

variable "vm_type" {
  description = "Tipe / spec node yang ingin digunakan"
  type = string
  default = "e2-small"
}

variable "vm_os_name" {
  description = "System Operasi yang digunakan untuk setiap node"
  type = string
  default = "centos-cloud/centos-7"
}

variable "vm_disk_size" {
  description = "Ukuran disk setiap node dengan satuan"
  type = number
  default = 50
}

variable "vm_user_ssh" {
  description = "username dan lokasi ssh key"
  type = map(string)
}


############################## Firewall ##############################
variable "fw_allow_tcp_docker" {
  description = "Port type tcp untuk diizinkan akses public"
  type = list(string)
}

variable "fw_allow_udp_docker" {
  description = "Port type udp untuk diizinkan akses public"
  type = list(string)
}

variable "fw_allow_tcp_secret" {
  description = "Port type tcp untuk diizinkan akses dari ip yang sudah terdaftar"
  type = list(string)
}

variable "fw_allow_udp_secret" {
  description = "Port type udp untuk diizinkan akses dari ip yang sudah terdaftar"
  type = list(string)
}

variable "fw_ip_whitelist" {
  description = "Daftar IP yang boleh mengakses port tcp/udp secret"
  type = list(string)
}


############################## Database ##############################
variable "db_tier" {
  description = "value"
  type = string
}

variable "db_version" {
  description = "value"
  type = string
}

variable "db_disk_size" {
  description = "value"
  type = number
  default = 10
}

variable "db_root_pass" {
  description = "value"
  type = string
}