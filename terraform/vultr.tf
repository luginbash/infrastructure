variable "VULTR_API_KEY" {}

provider "vultr" {
  api_key =  var.VULTR_API_KEY
  rate_limit = 700
}



resource "vultr_firewall_group" "internal" {}
resource "vultr_firewall_group" "edge" {}
resource "vultr_firewall_group" "default" {}

resource "vultr_server" "amstnlvl01" {
  plan_id = "401"
  os_id = "270" # ubuntu1804
  region_id = "7" # Amsterdam
  enable_ipv6 = true
  price_per_month = "12"
}


resource "vultr_server" "tokyjpvl01" {
  plan_id = "401"
  os_id = "270" # ubuntu1804
  region_id = "7" # Amsterdam
  enable_ipv6 = true
  price_per_month = "12"
}



