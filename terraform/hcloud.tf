variable "hcloud_token" {}

provider "hcloud" {
  token = var.hcloud_token
}

variable "SALT_MASTER" {}
variable "SALT_FINGER" {}

resource "hcloud_ssh_key" "openssh-sk" {
  name = "SK-Test"
  public_key = var.SSH_PUBKEY_1
}

resource "hcloud_server" "node1" {
  name = "node1"
  image = "ubuntu_2004"
  server_type = "cx21"
  location = "fsn1"
  user_data = data.template_cloudinit_config.vm-config.rendered
}

