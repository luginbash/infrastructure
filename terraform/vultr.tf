variable "VULTR_API_KEY" {}

provider "vultr" {
  api_key =  var.VULTR_API_KEY
  rate_limit = 700
}


data "vultr_plan" "hf12" {
  filter {
      name = "High Frequency 12 Dollar"
      values = ["1024 MB RAM,32G NVME"]
  }
}


resource "vultr_firewall_group" "internal" {}
resource "vultr_firewall_group" "edge" {}
resource "vultr_firewall_group" "default" {}


resource "vultr_server" "amstnlvl01" {
  plan_id = data.vultr_plan.hf12.name
  os_id = "270" # ubuntu1804
  region_id = "7" # Amsterdam
  enable_ipv6 = true
}


resource "vultr_server" "tokyjpvl01" {
  plan_id = data.vultr_plan.hf12.name
  os_id = "270" # ubuntu1804
  region_id = "7" # Amsterdam
  enable_ipv6 = true
}



