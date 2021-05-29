variable "VULTR_API_KEY" {}


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

resource "vultr_instance" "sjc01" {
  region = "sjc"
  plan = "vhf-1c-1gb"
  label = "sjc01"
  hostname = "sjc01.lug.sh"
  os_id = "352"
  enable_ipv6 = true
  activation_email = false
  user_data = data.template_cloudinit_config.vm-config.rendered
}

resource "vultr_instance" "sgp01" {
  region = "sgp"
  plan = "vhf-1c-1gb"
  label = "sgp01"
  hostname = "sgp01.lug.sh"
  os_id = "352"
  enable_ipv6 = true
  activation_email = false
  user_data = data.template_cloudinit_config.vm-config.rendered
}

resource "vultr_instance" "nrt01" {
  region = "nrt"
  plan = "vhf-1c-1gb"
  label = "nrt01"
  hostname = "nrt01.lug.sh"
  os_id = "352"
  enable_ipv6 = true
  activation_email = false
  user_data = data.template_cloudinit_config.vm-config.rendered
}

resource "vultr_instance" "ams01" {
  region = "ams"
  plan = "vhf-1c-1gb"
  label = "ams01"
  hostname = "ams01.lug.sh"
  os_id = "352"
  enable_ipv6 = true
  activation_email = false
  user_data = data.template_cloudinit_config.vm-config.rendered
}

