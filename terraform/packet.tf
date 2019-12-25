variable "PACKET_AUTH_TOKEN" {}
variable "PACKET_PROJECT" {}


provider packet {
  auth_token = var.PACKET_AUTH_TOKEN
}


locals {
  project_id = var.PACKET_PROJECT
}

resource "packet_device" "amstntpks01"{
  hostname = "amstntpks01.lug.sh"
  plan = "baremetal_0"
  facilities = ["ams1"]
  operating_system = "ubuntu_18_04"
  billing_cycle    = "hourly"
  project_id       = local.project_id
}

