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


