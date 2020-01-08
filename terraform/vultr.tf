variable "VULTR_API_KEY" {}

provider "vultr" {
  api_key =  var.VULTR_API_KEY
  rate_limit = 700
}

resource "vultr_firewall_group" "untrust" {
  description = "untrust"
}
resource "vultr_firewall_group" "default" {
  description = "default"
}


resource "vultr_server" "tokyjpvl01" {
  plan_id = "401" # HF12
  os_id = "252" # ubuntu1710
  region_id = "25" # Tokyo
}

resource "vultr_server" "amstnlvl01" {
  plan_id = "400" # HF6
  os_id = "270" # ubuntu1804
  region_id = "7" # Amsterdam
}

resource "vultr_server" "sngpsgvl01" {
  label = "sngpsgvl01"
  hostname = "sngpsgvl01.lug.sh"
  enable_ipv6 = true
  notify_activate = false
  plan_id = "201" # Normal 5
  os_id = "270" # Ubuntu 18.04
  region_id = "40" # Singapore
  user_data = data.template_cloudinit_config.vm-config.rendered
}

resource "tls_private_key" "sngpsgvl01_web" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_cert_request" "sngpsgvl01_web" {
  key_algorithm   = tls_private_key.sngpsgvl01.algorithm
  private_key_pem = tls_private_key.sngpsgvl01.private_key_pem

  subject {
    common_name  = "sngpsgvl01"
    organization = "Netzwerk Luginbash"
  }
}

resource "cloudflare_origin_ca_certificate" "sngpsgvl01_web" {
  csr                = tls_cert_request.sngpsgvl01_web.cert_request_pem
  hostnames          = [ tls_cert_request.sngpsgvl01_web.subject.common_name ]
  request_type       = "origin-rsa"
  requested_validity = 7
}
