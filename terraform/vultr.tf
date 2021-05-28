variable "VULTR_API_KEY" {}
variable "ssh_pubkeys" { type = list(string)  }


provider "vultr" {
  api_key    = var.VULTR_API_KEY
  rate_limit = 700
}

resource "vultr_firewall_group" "untrust" {
  description = "untrust"
}
resource "vultr_firewall_group" "sjc-inside" {
  description = "sjc-inside"
}

resource "vultr_firewall_group" "sgp-inside" {
  description = "sgp-inside"
}

resource "vultr_firewall_group" "nrt-inside" {
  description = "nrt-inside"
}

resource "vultr_firewall_group" "ams-inside" {
  description = "ams-inside"
}

resource "vultr_server" "sjc01" {
  region = "sjc"
  plan = "vhf-1c-1gb"
  label = "sjc01"
  hostname = "sjc01.lug.sh"
  os_id = "352"
  enable_ipv6 = true
  activation_email = false
  user_data = templatefile("${path.module}/init.yml",{
    master_user = var.master_user
    master_finger = var.master_finger
    master_addr = var.master_addr
  })
}

resource "vultr_server" "sgp01" {
  region = "sgp"
  plan = "vhf-1c-1gb"
  label = "sgp01"
  hostname = "sgp01.lug.sh"
  os_id = "352"
  enable_ipv6 = true
  activation_email = false
  user_data = templatefile("${path.module}/init.yml",{
    master_user = var.master_user
    master_finger = var.master_finger
    master_addr = var.master_addr
  })
}

resource "vultr_server" "nrt01" {
  region = "nrt"
  plan = "vhf-1c-1gb"
  label = "nrt01"
  hostname = "nrt01.lug.sh"
  os_id = "352"
  enable_ipv6 = true
  activation_email = false
  user_data = templatefile("${path.module}/init.yml",{
    master_user = var.master_user
    master_finger = var.master_finger
    master_addr = var.master_addr
  })
}

resource "vultr_server" "ams01" {
  region = "ams"
  plan = "vhf-1c-1gb"
  label = "ams01"
  hostname = "ams01.lug.sh"
  os_id = "352"
  enable_ipv6 = true
  activation_email = false
  user_data = templatefile("${path.module}/init.yml",{
    master_user = var.master_user
    master_finger = var.master_finger
    master_addr = var.master_addr
  })
}

