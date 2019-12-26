variable "PACKET_AUTH_TOKEN" {}
variable "PACKET_PROJECT" {}
variable "SALT_MASTER" {}
variable "SALT_FINGER" {}

provider packet {
  auth_token = var.PACKET_AUTH_TOKEN
}


locals {
  project_id = var.PACKET_PROJECT
}

data "template_file" "init" {
  template = file("${path.module}/init.tpl")
  vars = {
    master_addr = var.SALT_MASTER
    master_finger = var.SALT_FINGER
  }
}

resource "packet_device" "amstnlpks01" {
  hostname = "amstnlpks01.lug.sh"
  plan = "baremetal_0"
  facilities = ["ams1"]
  operating_system = "ubuntu_18_04"
  billing_cycle = "hourly"
  user_data = data.template_file.init.rendered
  project_id = local.project_id
}


