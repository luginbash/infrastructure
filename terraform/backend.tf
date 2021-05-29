terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "lug-sh"
    workspaces { name = "infrastructure" } 
  }
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "2.3.0"
    }
  }
}

