terraform {
  backend "remote" {
  hostname = "app.terraform.io"
  organization = "lug-sh"
  workspaces { name = "infrastructure" } 
  }
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
    packet = {
      source = "packethost/packet"
    }
    vultr = {
      source = "vultr/vultr"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    heroku = {
      source = "heroku/heroku"
    }
  }
}

