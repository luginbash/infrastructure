variable "cloudflare_account_id" {}
variable "cloudflare_api_token" {}
variable "bootstrap_zone" {}

provider "cloudflare" {
  version    = "~> 2.0"
  account_id = var.cloudflare_account_id
  api_token  = var.cloudflare_api_token
}

data "cloudflare_zones" "infra" {
  filter {
    name = var.bootstrap_zone
    status = "active"
    paused = false
  }
}

resource "cloudflare_zone" "zone" {
  zone = var.bootstrap_zone
  plan = "free"
}


