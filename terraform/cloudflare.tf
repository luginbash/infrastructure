variable "cloudflare_account_id" {}
variable "cloudflare_api_token" {}
variable "cloudflare_zone" {}

provider "cloudflare" {
  account_id = var.cloudflare_account_id
  api_token  = var.cloudflare_api_token
}

resource "cloudflare_zone" "zone" {
  zone = var.cloudflare_zone
  plan = "free"
}


