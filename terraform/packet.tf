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


resource "packet_device" "tokyjppks01" {
  hostname = "tokyjppk01.lug.sh"
  plan = "baremetal_0"
  facilities = ["nrt1"]
  operating_system = "ubuntu_18_04"
  billing_cycle = "hourly"
  user_data = data.template_file.init.rendered
  project_id = local.project_id
}

