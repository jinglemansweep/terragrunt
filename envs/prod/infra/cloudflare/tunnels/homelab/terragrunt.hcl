include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules//cloudflare/access/tunnel"
}

inputs = {
  account_name  = "Personal Account"
  team_name     = "pt"
  tunnel_name   = "Home"
  tunnel_secret = "xxx"
  tunnel_ingress_rules = [
    {
      hostname      = "hass.ptre.net"
      service       = "http://hass.home:8123"
      access        = true
      audience_tags = ["test"]
    },
    {
      hostname      = "grafana.ptre.uk"
      service       = "http://dsm1.home:3000"
      access        = true
      audience_tags = ["test"]
    },

  ]
  seckey_cloudflare_api_token = "CLOUDFLARE_API_TOKEN"
}
