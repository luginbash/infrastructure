variable "VULTR_API_KEY" {}

provider "vultr" {
  api_key =  var.VULTR_API_KEY
  rate_limit = 700
}


data "vultr_plan" "hf12" {
  filter {
      name = "disk"
      values = ["64"]
  }
}


resource "vultr_firewall_group" "untrust" {}
resource "vultr_firewall_group" "default" {}


resource "vultr_server" "amstnlvl01" {
  plan_id = "199"
  os_id = "270" # ubuntu1710 
  region_id = "7" # Amsterdam
}


resource "vultr_server" "tokyjpvl01" {
  plan_id = "401"
  os_id = "270" # ubuntu1804
  region_id = "25" # Tokyo
}



