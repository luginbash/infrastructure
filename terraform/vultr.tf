resource "vultr_firewall_group" "untrust" {
  description = "untrust"
}
resource "vultr_private_network" "sjc_inside" {
  description = "sjc_inside"
  region = "sjc"
}

resource "vultr_private_network" "sgp_inside" {
  description = "sgp_inside"
  region = "sgp"
}

resource "vultr_private_network" "ams_inside" {
  description = "ams_inside"
  region = "ams"
}


resource "vultr_private_network" "nrt_inside" {
  description = "nrt_inside"
  region = "nrt"
}
resource "vultr_instance" "master_nrt01" {
  region = "nrt"
  backups = "enabled"
  plan = "vhf-1c-2gb"
  label = "master_nrt01"
  os_id = "352"
  private_network_ids = [ vultr_private_network.nrt_inside.id ]
  enable_ipv6 = true
  lifecycle {
    ignore_changes = [ os_id, user_data  ]
  }
  backups_schedule {
   dom  = 0 
   dow  = 0 
   hour = 18
   type = "daily_alt_even"
  }
}
resource "vultr_instance" "sjc01" {
  region = "sjc"
  plan = "vhf-1c-1gb"
  label = "sjc01"
  hostname = "edge-sjc01.lug.sh"
  os_id = "352"
  enable_ipv6 = true
  activation_email = false
  private_network_ids = [ vultr_private_network.sjc_inside.id ]
  user_data = data.template_cloudinit_config.vm-config.rendered

  lifecycle {
    ignore_changes = [ os_id, user_data  ]
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
  private_network_ids = [ vultr_private_network.sgp_inside.id ]
  user_data = data.template_cloudinit_config.vm-config.rendered

  lifecycle {
    ignore_changes = [ os_id, user_data  ]
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
  private_network_ids = [ vultr_private_network.ams_inside.id ]
  user_data = data.template_cloudinit_config.vm-config.rendered

  lifecycle {
    ignore_changes = [ os_id, user_data  ]
  }
}

