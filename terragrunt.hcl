generate "backend_tfc" {
  path      = "_backend_tfc.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = ">= 1.5"
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "peachtrees"
    workspaces {
      name = "${replace(path_relative_to_include(), "/", "-")}"
    }
  }
  required_providers {
    infisical = {
      source = "infisical/infisical"
      version = "~> 0.3"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.1"
    }
  }
}
EOF
}

generate "provider_infisical" {
  path      = "_provider_infisical.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
variable "infisical_client_id" {}
variable "infisical_client_secret" {}
variable "infisical_workspace_id" {}
provider "infisical" {
  host          = "https://app.infisical.com"
  client_id     = var.infisical_client_id
  client_secret = var.infisical_client_secret
}
data "infisical_secrets" "secrets" {
  env_slug    = "prod"
  workspace_id = var.infisical_workspace_id
  folder_path = "/"
}
EOF
}
