terraform {
  required_version = ">= 1.5"
}

provider "cloudflare" {
  api_token = data.infisical_secrets.secrets.secrets[var.seckey_cloudflare_api_token].value
}

resource "cloudflare_account" "account" {
  name = var.account_name
}

# Tunnel

resource "cloudflare_tunnel" "tunnel" {
  account_id = cloudflare_account.account.id
  name       = var.account_name
  secret     = var.tunnel_secret
}

# Tunnel Config

resource "cloudflare_tunnel_config" "tunnel_config" {
  account_id = cloudflare_account.account.id
  tunnel_id  = cloudflare_tunnel.tunnel.id
  config {
    dynamic "ingress_rule" {
      for_each = var.tunnel_ingress_rules
      content {
        hostname = ingress_rule.value.hostname
        service  = ingress_rule.value.service
        origin_request {
          access {
            required  = ingress_rule.value.access
            team_name = var.team_name
            aud_tag   = ingress_rule.value.audience_tags
          }
        }
      }
    }
  }
}
