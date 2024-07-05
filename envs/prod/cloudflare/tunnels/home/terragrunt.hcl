include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules//cloudflare/access/tunnel"
}

dependency "app_net_ptre" {
  config_path = "../../access/applications/net_ptre"
}

dependency "app_uk_ptre" {
  config_path = "../../access/applications/uk_ptre"
}


inputs = {
  account_name = "Personal Account"
  team_name    = "pt"
  tunnel_name  = "Home"
  tunnel_ingress_rules = [
    {
      hostname      = "hass.ptre.net"
      service       = "http://hass.home:8123"
      access        = true
      audience_tags = [dependency.app_net_ptre.outputs.application.aud]
    },
    {
      hostname      = "grafana.ptre.uk"
      service       = "http://dsm1.home:3000"
      access        = true
      audience_tags = [dependency.app_uk_ptre.outputs.application.aud]
    },

  ]
  seckey_cloudflare_api_token = "CLOUDFLARE_API_TOKEN"
  seckey_tunnel_secret        = "CLOUDFLARE_TUNNEL_SECRET_HOMELAB"
}
