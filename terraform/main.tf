variable "SALT_USER" {}
variable "SSH_PUBKEY_1" {}
variable "SSH_PUBKEY_2" {}
variable "SSH_PUBKEY_3" {}
variable "SSH_PUBKEY_4" {}
variable "SSH_PUBKEY_5" {}

data "template_file" "init" {
  template = file("${path.module}/init.tpl")

  vars = {
    master_finger = var.SALT_FINGER
    master_addr = var.SALT_MASTER
    master_user = var.SALT_USER
  }
}

data "template_cloudinit_config" "vm-config" {
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.script.rendered}"
  }
}


