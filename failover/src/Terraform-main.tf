terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  zone      = "ru-central1-b"
  token     = var.token
  cloud_id  = var.cloud
  folder_id = var.folder
}
resource "yandex_lb_network_load_balancer" "balancer" {
  name = "network-load-balancer"

  listener {
    name = "my-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.targetgroup.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

resource "yandex_lb_target_group" "targetgroup" {
  name      = "target-group"
  region_id = "ru-central1"

  target {
    subnet_id = yandex_vpc_subnet.sub1.id
    address   = yandex_compute_instance.my-mashine[0].network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.sub1.id
    address   = yandex_compute_instance.my-mashine[1].network_interface.0.ip_address
  }
}

resource "yandex_compute_instance" "my-mashine" {
  count                     = 2
  name                      = "vm-${count.index}"
  allow_stopping_for_update = true
  platform_id               = "standard-v1"
  zone                      = "ru-central1-b"
  hostname                  = "vm-${count.index}"
  resources {
    cores         = "2"
    memory        = "2"
    core_fraction = "20"
  }

  boot_disk {
    initialize_params {
      image_id = "fd83i63l9ksu47pqmp08"
    }
  }
  scheduling_policy {
    preemptible = "true"
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.sub1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./Terraform-meta.txt")}"
  }
}

resource "yandex_vpc_network" "sub1" {
  name = "sflt"
}

resource "yandex_vpc_subnet" "sub1" {
  name           = "subsflt"
  zone           = "ru-central1-b"
  v4_cidr_blocks = ["192.168.10.0/24"]
  network_id     = yandex_vpc_network.sub1.id
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.my-mashine[0].network_interface.0.ip_address
}
output "external_ip_address_vm_1" {
  value = yandex_compute_instance.my-mashine[0].network_interface.0.nat_ip_address
}
output "internal_ip_address_vm_2" {
  value = yandex_compute_instance.my-mashine[1].network_interface.0.ip_address
}
output "external_ip_address_vm_2" {
  value = yandex_compute_instance.my-mashine[1].network_interface.0.nat_ip_address
}