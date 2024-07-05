terraform {
  required_version = ">= 1.5"
}

provider "cloudflare" {
  api_token = data.infisical_secrets.secrets.secrets["CLOUDFLARE_API_TOKEN"].value
}

# Tunnel

resource "cloudflare_tunnel" "tunnel" {
  account_id = var.account.id
  name       = var.tunnel_name
  secret     = data.infisical_secrets.secrets.secrets["CLOUDFLARE_TUNNEL_SECRET_HOMELAB"].value
}

# Tunnel Config

resource "cloudflare_tunnel_config" "tunnel_config" {
  account_id = var.account.id
  tunnel_id  = cloudflare_tunnel.tunnel.id
  config {
    warp_routing {
      enabled = true
    }
    dynamic "ingress_rule" {
      for_each = var.tunnel_ingress_rules
      content {
        hostname = ingress_rule.value.hostname
        service  = ingress_rule.value.service
      }
    }
  }
}
