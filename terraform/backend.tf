terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "lug-sh"
    workspaces { name = "infrastructure" } 
  }
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~> 1.23"
    }
    packet = {
      source = "packethost/packet"
      version = "~> 3.0"
    }
    vultr = {
      source = "vultr/vultr"
      version = "~> 1.5"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 2.13"
    }
    google = {
      source = "-/google"
      version = "~> 3.47"
    }
  }
}

