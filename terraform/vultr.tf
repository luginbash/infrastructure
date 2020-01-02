variable "VULTR_API_KEY" {}
variable "SALT_USER" {}

provider "vultr" {
  api_key =  var.VULTR_API_KEY
  rate_limit = 700
}

data "template_file" "script" {
  template = file("${path.module}/init.tpl")

  vars {
    master_finger = var.SALT_FINGER
    master_addr = var.SALT_MASTER
    master_user = var.SALT_USER
  }
}

data "template_cloudinit_config" "vm-config" {
  base64_encode = true
  content      = "${data.template_file.script.rendered}"
}

resource "vultr_firewall_group" "untrust" {
  description = "untrust"
}
resource "vultr_firewall_group" "default" {
  description = "default"
}



resource "vultr_server" "tokyjpvl01" {
  plan_id = "401" # HF12
  os_id = "252" # ubuntu1710
  region_id = "25" # Tokyo
}

resource "vultr_server" "amstnlvl01" {
  plan_id = "400" # HF6
  os_id = "270" # ubuntu1710
  region_id = "7" # Amsterdam
}

resource "vultr_server" "sngpsgvl01" {
  label = "sngpsgvl01"
  hostname = "sngpsgvl01.lug.sh"
  enable_ipv6 = true
  notify_activate = false
  plan_id = "201" # Normal 5
  os_id = "270" # Ubuntu 18.04
  region_id = "40" # Singapore
  user_data = data.template_cloudinit_config.vm-config.rendered
}
