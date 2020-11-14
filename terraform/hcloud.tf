# imports

variable "hcloud_token" {}
variable "default_k3os_ver" {}
variable "default_cidr_offset" { default = 2 }
variable "hcloud_k3s_fqdn" {}
variable "hcloud_master_server_type" {}
variable "hcloud_network" { type = map(string) }
variable "hcloud_node_server_type" {}
variable "hcloud_presence" { type = list(map(object({
  code = string
  region = string
  count = number
}))) }
variable "ssh_pubkeys" { type = list(string)  }

provider "random" {
  version = "~> 2.2"
}

provider "hcloud" {
  token = var.hcloud_token
}

# locals

locals {
  hosts_numbered = sort(flatten([for region in var.hcloud_presence : [for elem in range(region["count"]) : "${region["code"]}-s${elem}"]]))
}

# resources
resource "random_string" "k3s_token" {
  length = 64
  special = false
}

resource "random_pet" "servers" {
  for_each = toset(local.hosts_numbered)
  length   = 2
  keepers = {
    k3os_ver = var.default_k3os_ver
  }
}

resource "random_pet" "networks" {
  length = 1
}

resource "hcloud_network" "vpc" {
  name     = random_pet.networks.id
  ip_range = var.hcloud_network["vpc"]
}

resource "hcloud_network_subnet" "subnet" {
  network_id   = hcloud_network.vpc.id
  type         = "server" # required?
  network_zone = var.hcloud_network["zone"]
  ip_range     = var.hcloud_network["host"]
}

resource "hcloud_server" "hosts" {
  for_each    = random_pet.servers
  location    = each.value.code
  name        = each.key
  image       = "debian-10"
  iso         = "k3os-amd64_v0.11.0.iso"
  server_type = each.value.idx== 0 ? var.hcloud_master_server_type : var.hcloud_node_server_type
  user_data   = each.value.idx == 0 ? templatefile(
    "${path.module}/init-hcloud-k3os-srv.tpl", {
    ssh_pubkeys = var.ssh_pubkeys,
    server_url = "https://${hcloud_server.hosts[0].ipv4_address}:6443",
    token = random_string.k3s_token
  }): templatefile(
    "${path.module}/init-hcloud-k3os-agt.tpl", {
      ssh_pubkeys = var.ssh_pubkeys,
      server_url = "https://${hcloud_server.hosts[0].ipv4_address}:6443",
      token = random_string.k3s_token
    })
}

