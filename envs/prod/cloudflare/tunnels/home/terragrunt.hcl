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

inputs = {
  account = dependency.account_home.outputs.account
  team_name    = "pt"
  tunnel_name  = "Home"
  tunnel_ingress_rules = [
    {
      hostname      = "hass.ptre.net"
      service       = "http://hass.adm.ptre.es:8123"
    },
    {
      hostname      = "ds920p.ptre.net"
      service       = "http://ds920p.adm.ptre.es:5000"
    },
    {
      hostname      = "coder.ptre.net"
      service       = "http://core.adm.ptre.es:7080"
    },
    {
      hostname      = "pvm1.ptre.net"
      service       = "https://pvm1.adm.ptre.es:8006"
    },
    {
      hostname      = "pvm2.ptre.net"
      service       = "https://pvm2.adm.ptre.es:8006"
    },
    {
      hostname      = "pvm3.ptre.net"
      service       = "https://pvm3.adm.ptre.es:8006"
    },
    {
      hostname      = "rundeck.ptre.net"
      service       = "http://core.adm.ptre.es:4440"
    },
    {
      hostname      = "vuduo.ptre.net"
      service       = "http://vuduo.adm.ptre.es:80"
    },
    {
      hostname      = null
      service       = "http_status:503"
    },
  ]
  seckey_cloudflare_api_token = "CLOUDFLARE_API_TOKEN"
  seckey_tunnel_secret        = "CLOUDFLARE_TUNNEL_SECRET_HOMELAB"
}
