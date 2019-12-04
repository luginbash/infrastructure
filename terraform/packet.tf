variable "PACKET_AUTH_TOKEN" {}
variable "PACKET_PROJECT" {}


provider packet {
  auth_token = var.PACKET_AUTH_TOKEN
}


locals {
  project_id = var.PACKET_PROJECT
}

data "packet_spot_market_price" "amsterdam" {
  facility = "ams1"
  plan     = "baremetal_0"
}

