provider "aws" {
  region = "us-east-1"
}
provider "vault" {
  address = "http://vault-internal.masdevops.online:8200"
  token   = var.vault_token
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}