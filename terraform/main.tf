variable "SALT_USER" {}
variable "SALT_MASTER" {}
variable "SALT_FINGER" {}

provider "google" {
   project     = var.GOOGLE_CLOUD_PROJECT
   region      = var.GOOGLE_CLOUD_REGION_DEFAULT
}
variable "GOOGLE_CLOUD_REGION_DEFAULT" {}
variable "GOOGLE_CLOUD_PROJECT" {}


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
    content      = data.template_file.init.rendered
  }
}


