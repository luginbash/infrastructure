variable "VULTR_API_KEY" {}

provider "vultr" {
  api_key    = var.VULTR_API_KEY
  rate_limit = 700
}

resource "vultr_firewall_group" "untrust" {
  description = "untrust"
}
resource "vultr_firewall_group" "default" {
  description = "default"
}


resource "vultr_server" "tokyjpvl01" {
  plan_id   = "401" # HF12
  os_id     = "252" # ubuntu1710
  region_id = "25"  # Tokyo
}

resource "vultr_server" "amstnlvl01" {
  plan_id   = "400" # HF6
  os_id     = "270" # ubuntu1804
  region_id = "7"   # Amsterdam
}


