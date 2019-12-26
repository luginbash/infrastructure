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

resource "vultr_firewall_group" "untrust" {
  description = "untrust"
}
resource "vultr_firewall_group" "default" {
  description = "default"
}



resource "vultr_server" "tokyjpvl01" {
  plan_id = "401"
  os_id = "252" # ubuntu1710
  region_id = "25" # Tokyo
}

resource "vultr_server" "amstnlvl01" {
  plan_id = "400" # HF6
  os_id = "270" # ubuntu1710
  region_id = "7" # Tokyo
}


