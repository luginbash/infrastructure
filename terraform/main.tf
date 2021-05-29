variable "SALT_USER" {}
variable "SALT_MASTER" {}
variable "SALT_FINGER" {}

provider "vultr" {
  rate_limit = 700
  retry_limit = 3
}

data "template_file" "init" {
  template = file("${path.module}/init.yml")

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


