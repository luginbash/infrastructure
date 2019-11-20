variable "VULTR_API_KEY" {}
variable "vultr_HF_12" {}

provider "vultr" {
  api_key =  var.VULTR_API_KEY
  rate_limit = 700
}



resource "vultr_firewall_group" "internal" {}
resource "vultr_firewall_group" "edge" {}
resource "vultr_firewall_group" "default" {}

resource "vultr_server" "amstnlvl01" {}
resource "vultr_server" "tokyjpvl01" {}



