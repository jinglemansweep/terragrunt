terraform {
  required_version = ">= 1.5"
}

provider "cloudflare" {
  api_token = data.infisical_secrets.secrets.secrets[var.seckey_cloudflare_api_token].value
}

# Tunnel

resource "cloudflare_tunnel" "tunnel" {
  account_id = var.account.id
  name       = var.tunnel_name
  secret     = data.infisical_secrets.secrets.secrets[var.seckey_tunnel_secret].value
}

# Tunnel Config

resource "cloudflare_tunnel_config" "tunnel_config" {
  account_id = var.account.id
  tunnel_id  = cloudflare_tunnel.tunnel.id
  config {
    dynamic "ingress_rule" {
      for_each = var.tunnel_ingress_rules
      content {
        hostname = ingress_rule.value.hostname
        service  = ingress_rule.value.service
        #origin_request {
        #  access {
        #    required  = ingress_rule.value.access
        #    team_name = var.team_name
        #    aud_tag   = ingress_rule.value.audience_tags
        #  }
        #}
      }
    }
  }
}
