terraform {
  required_version = ">= 1.5"
}

provider "cloudflare" {
  api_token = data.infisical_secrets.secrets.secrets[var.seckey_cloudflare_api_token].value
}

resource "cloudflare_account" "account" {
  name = var.account_name
}