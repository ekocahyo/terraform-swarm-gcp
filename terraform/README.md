# Component
- Computer engine for Docker Swarm (manager+worker)
- Cloud SQL
- Cloud Storage

# How to play

## Generate ssh-key
```bash
ssh-keygen -o -a 100 -t ed25519 -f /home/user/path/id_rsa_user1 -C "user1"
ssh-keygen -o -a 100 -t ed25519 -f /home/user/path/id_rsa_user2 -C "user2"
```

## Create workspace
```bash
terraform workspace new production
terraform workspace new stage
```

## Deploy for stage environment
```bash
terraform workspace select stage
terraform init
terraform plan --var-file="env-stage.tfvars"
terraform apply --var-file="env-stage.tfvars"
```

## Deploy for production environment
```bash
terraform workspace select production
terraform init
terraform plan --var-file="env-prod.tfvars"
terraform apply --var-file="env-prod.tfvars"
```

## Deploy Select Resource
```bash
terraform init
terraform plan --var-file="env-prod.tfvars" -target=google_compute_instance.docker_prod_manager
terraform apply --var-file="env-prod.tfvars" -target=google_compute_instance.docker_prod_manager
```

## Destroy All
```bash
terraform destroy --var-file="env-prod.tfvars"
```

# Inputs

## Project
| Name                | Description                                         | Type     | Default               | example                  |
|---------------------|-----------------------------------------------------|----------|-----------------------|--------------------------|
| project_credentials | Lokasi file credential GCP yang Anda dapat dari IAM | `string` | n/a                   | `"~/Documents/key.json"` |
| project_name        | Pilih code project untuk deploy service             | `string` | n/a                   | `"cloud-test"`           |
| project_region      | Pilih region untuk project                          | `string` | `"asia-southeast2"`   | `"asia-southeast2"`      |
| project_zone        | Pilih zone untuk project                            | `string` | `"asia-southeast2-a"` | `"asia-southeast2-a"`    |
| project_prefix_name | Untuk Prefix penamaan semua module                  | `string` | n/a                   | `"myproject"`            |

## Compute Engine
| Name             | Description                                                                                                                             | Type          | Default                   | example                                                                                                  |
|------------------|-----------------------------------------------------------------------------------------------------------------------------------------|---------------|---------------------------|----------------------------------------------------------------------------------------------------------|
| vm_manager_count | Jumlah node yang ingin di install untuk manager docker swarm                                                                            | `number`      | 1                         | 1                                                                                                        |
| vm_worker_count  | Jumlah node yang ingin di install untuk worker docker swarm                                                                             | `number`      | 0                         | 0                                                                                                        |
| vm_type          | Tipe / spec node yang ingin digunakan <br>*ref: gcloud compute machine-types list --filter="zone:( asia-southeast2-a )" --sort-by=CPUS* | `string`      | `"e2-small"`              | `"e2-small"`                                                                                             |
| vm_os_name       | System Operasi yang digunakan untuk setiap node <br>*ref: gcloud compute images list*                                                   | `string`      | `"centos-cloud/centos-7"` | `"centos-cloud/centos-7"`                                                                                |
| vm_disk_size     | Ukuran disk setiap node dengan satuan GB                                                                                                | `number`      | 50                        | 50                                                                                                       |
| vm_user_ssh      | username dan lokasi ssh key                                                                                                             | `map(string)` | n/a                       | {<br>`"user1" = "/home/user/path/id_rsa_user1.pub"`,<br> `"user2" = "/home/user/path/id_rsa_user2.pub"`<br>} |

## Firewall
| Name                | Description                                                        | Type           | Default        | example           |
|---------------------|--------------------------------------------------------------------|----------------|----------------|-------------------|
| fw_allow_tcp_docker | Port type *tcp* untuk diizinkan akses public                       | `list(string)` | `["80","443"]` | `["80","443"]`    |
| fw_allow_udp_docker | Port type *udp* untuk diizinkan akses public                       | `list(string)` | n/a            | `["7946","4789"]` |
| fw_allow_tcp_secret | Port type *tcp* untuk diizinkan akses dari ip yang sudah terdaftar | `list(string)` | `["22"]`       | `["22"]`          |
| fw_allow_udp_secret | Port type *tcp* untuk diizinkan akses dari ip yang sudah terdaftar | `list(string)` | n/a            | `["7946","4789"]` |
| fw_ip_whitelist     | Daftar IP yang boleh mengakses port tcp/udp secret                 | `list(string)` | n/a            | `["0.0.0.0"]`     |

## MySQL
| Name         | Description                                                                        | Type     | Default       | example         |
|--------------|------------------------------------------------------------------------------------|----------|---------------|-----------------|
| db_tier      | Tipe / spec node yang ingin digunakan<br>*ref:gcloud sql tiers list --sort-by=RAM* | `string` | n/a           | `"db-g1-small"` |
| db_version   | Versi dari MySQL server                                                            | `string` | n/a | `"MYSQL_8_0"`   |
| db_disk_size | Ukuran disk untuk MySQL server (*satuan GB*)                                       | `number` | 10            | 10              |
| db_root_pass | Password root MySQL                                                                | `string` | n/a           | `"Admin@123"`   |

# Outputs

| Name       | Description                                     |
|------------|-------------------------------------------------|
| vm_manager | Daftar IP Public dari node manager docker swarm |
| vm_worker  | Daftar IP Public dari node worker docker swarm  |
| gs_address | URL google storage                              |