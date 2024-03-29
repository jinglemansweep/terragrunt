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
variable "infisical_service_token" {}
provider "infisical" {
  host          = "https://app.infisical.com"
  service_token = var.infisical_service_token
}
data "infisical_secrets" "secrets" {
  env_slug    = "prod"
  folder_path = "/"
}
EOF
}
