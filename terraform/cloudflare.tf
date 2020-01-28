variable "cloudflare_account_id" {}
variable "cloudflare_api_token" {}
variable "cloudflare_zone_id" {}

provider "cloudflare" {
  version    = "~> 2.0"
  account_id = var.cloudflare_account_id
  api_token  = var.cloudflare_api_token
}

resource "cloudflare_zone" "zone" {
  id = var.bootstrap_zone
  plan = "free"
}


