resource "vultr_firewall_group" "untrust" {
  description = "untrust"
}
resource "vultr_private_network" "sjc-inside" {
  description = "sjc-inside"
  region = "sjc"
}

resource "vultr_private_network" "sgp-inside" {
  description = "sgp-inside"
  region = "sgp"
}

resource "vultr_private_network" "nrt-inside" {
  description = "nrt-inside"
  region = "nrt"
}

resource "vultr_private_network" "ams-inside" {
  description = "ams-inside"
  region = "ams"
}

resource "vultr_instance" "sjc01" {
  region = "sjc"
  plan = "vhf-1c-1gb"
  label = "sjc01"
  hostname = "edge-sjc01.lug.sh"
  os_id = "352"
  enable_ipv6 = true
  activation_email = false
  user_data = data.template_cloudinit_config.vm-config.rendered

  lifecycle {
    ignore_changes = [ "os_id"  ]
  }
}

resource "vultr_instance" "sgp01" {
  region = "sgp"
  plan = "vhf-1c-1gb"
  label = "sgp01"
  hostname = "edge-sgp01.lug.sh"
  os_id = "352"
  enable_ipv6 = true
  activation_email = false
  user_data = data.template_cloudinit_config.vm-config.rendered

  lifecycle {
    ignore_changes = [ "os_id"  ]
  }
}

resource "vultr_instance" "nrt01" {
  region = "nrt"
  plan = "vhf-1c-1gb"
  label = "nrt01"
  hostname = "edge-nrt01.lug.sh"
  os_id = "352"
  enable_ipv6 = true
  activation_email = false
  user_data = data.template_cloudinit_config.vm-config.rendered

  lifecycle {
    ignore_changes = [ "os_id"  ]
  }
}

resource "vultr_instance" "ams01" {
  region = "ams"
  plan = "vhf-1c-1gb"
  label = "ams01"
  hostname = "edge-ams01.lug.sh"
  os_id = "352"
  enable_ipv6 = true
  activation_email = false
  user_data = data.template_cloudinit_config.vm-config.rendered

  lifecycle {
    ignore_changes = [ "os_id"  ]
  }
}

