terraform {
  required_version = ">= 1.3.0"

  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = ">= 0.7.0"
    }
  }
}

variable "libvirt_uri" {
  type    = string
  default = "qemu+ssh://vilius@192.168.1.4/system"
}

variable "pool_name" {
  type    = string
  default = "default"
}

variable "template_volume_name" {
  # Must exist in the pool: virsh vol-list default
  type    = string
  default = "debian12-template.qcow2"
}

variable "vm_name" {
  type    = string
  default = "debian12-01"
}

variable "network_name" {
  # Existing libvirt network, usually "default"
  type    = string
  default = "default"
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

provider "libvirt" {
  uri = var.libvirt_uri
}

locals {
  ssh_pubkey = file(pathexpand(var.ssh_public_key_path))
}

data "libvirt_volume" "template" {
  name = var.template_volume_name
  pool = var.pool_name
}

resource "libvirt_volume" "root" {
  name           = "${var.vm_name}.qcow2"
  pool           = var.pool_name
  base_volume_id = data.libvirt_volume.template.id
  format         = "qcow2"
}

resource "libvirt_cloudinit_disk" "cidata" {
  name = "${var.vm_name}-cidata.iso"
  pool = var.pool_name

  user_data = <<-EOF
    #cloud-config
    hostname: ${var.vm_name}
    users:
      - name: debian
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
          - ${local.ssh_pubkey}
    ssh_pwauth: false
    disable_root: true
    package_update: true
  EOF
}

resource "libvirt_domain" "vm" {
  name   = var.vm_name
  memory = 2048
  vcpu   = 2

  cloudinit = libvirt_cloudinit_disk.cidata.id

  disk {
    volume_id = libvirt_volume.root.id
  }

  network_interface {
    network_name   = var.network_name
    wait_for_lease = true
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
}

output "vm_ip" {
  value = try(libvirt_domain.vm.network_interface[0].addresses[0], null)
}

