include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules//cloudflare/access/tunnel"
}

dependency "account_home" {
  config_path = "../../accounts/home"
}

dependency "apps_net_ptre" {
  config_path = "../../access/net_ptre"
}

inputs = {
  account = dependency.account_home.outputs.account
  team_name    = "pt"
  tunnel_name  = "Home"
  tunnel_ingress_rules = [
    {
      hostname      = "hass.ptre.net"
      service       = "http://hass.adm.ptre.es:8123"
      access        = true
      audience_tags = [dependency.apps_net_ptre.outputs.applications["hass"].aud]
    },
    {
      hostname      = "ds920p.ptre.net"
      service       = "http://ds920p.adm.ptre.es:5000"
      access        = true
      audience_tags = [dependency.apps_net_ptre.outputs.applications["ds920p"].aud]
    },
    {
      hostname      = "coder.ptre.net"
      service       = "http://core.adm.ptre.es:7080"
      access        = true
      audience_tags = [dependency.apps_net_ptre.outputs.applications["coder"].aud]
    },
    {
      hostname      = null
      service       = "http_status:503"
      access        = true
      audience_tags = []
    },
  ]
  seckey_cloudflare_api_token = "CLOUDFLARE_API_TOKEN"
  seckey_tunnel_secret        = "CLOUDFLARE_TUNNEL_SECRET_HOMELAB"
}
