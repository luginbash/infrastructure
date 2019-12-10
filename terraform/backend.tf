terraform {
  backend "remote" {
  hostname = "app.terraform.io"
  organization = "lug-sh"
  workspaces { name = "infrastructure" } 
  }
}

