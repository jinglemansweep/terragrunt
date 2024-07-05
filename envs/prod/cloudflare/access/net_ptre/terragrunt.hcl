include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules//cloudflare/access/application"
}

dependency "zone_net_ptre" {
  config_path = "../../dns/net_ptre"
}

inputs = {
  zone = dependency.zone_net_ptre.outputs.zone
  applications = [
    {
      name = "Home Assistant",
      subdomain = "hass2"
      tags = ["homeassistant", "hass", "iot"]
      logo_url = "https://upload.wikimedia.org/wikipedia/commons/6/6e/Home_Assistant_Logo.svg"
    }
  ]
  seckey_cloudflare_api_token = "CLOUDFLARE_API_TOKEN"
}
