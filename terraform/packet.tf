variable "PACKET_AUTH_TOKEN" {}
variable "PACKET_PROJECT" {}
variable "PACKET_BGP_MD5" {}
variable "PACKET_MY_ASN" {}
variable "PACKET_MY_PREFIX" {}
variable "SALT_MASTER" {}
variable "SALT_FINGER" {}

provider packet {
  auth_token = var.PACKET_AUTH_TOKEN
}


locals {
  project_id = var.PACKET_PROJECT
}

data "template_file" "init" {
  template = "${file("${path.module}/init.tpl")}"
  vars = {
    my_ip = "${packet_device.amstntpks01.network.2.address}"
    gw_ip = "${packet_device.amstntpks01.network.2.gateway}"
    my_prefix = "${var.PACKET_MY_PREFIX}"
    my_asn = "{var.PACKET_MY_ASN}"
    bgp_password = "${var.PACKET_BGP_MD5}"
    master_addr = "${var.salt_master}"
    master_finger = "${var.master_finger}"
  }
}

resource "packet_device" "amstntpks01"{
  hostname = "amstntpks01.lug.sh"
  plan = "baremetal_0"
  facilities = ["ams1"]
  operating_system = "ubuntu_18_04"
  billing_cycle    = "hourly"
  user_data        = "${data.template_file.init.rendered}"
  project_id       = local.project_id
}


