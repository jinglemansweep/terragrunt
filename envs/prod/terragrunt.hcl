generate "remote_state" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "peachtrees"
    workspaces {
      name = "${replace(path_relative_to_include(), "/" ,"-")}"
    }
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.1"
    }
    infisical = {
      source = "infisical/infisical"
      version = "~> 0.3"
    }
  }
}
EOF
}

generate "variables" {
  path ="variables_root.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
variable "infisical_service_key" {}
EOF
}

generate "provider_secrets" {
  path      = "provider_secrets.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "infisical" {
  host          = "https://app.infisical.com"
  service_token = var.infisical_service_key
}
EOF
}

generate "data_secrets" {
    path = "data.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
data "infisical_secrets" "secrets" {
  env_slug    = "prod"
  folder_path = "/"
}
EOF
}
