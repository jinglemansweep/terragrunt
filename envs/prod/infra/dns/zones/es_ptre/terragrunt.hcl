include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules//dns/cloudflare"
}

inputs = {
  account_name = "Personal Account"
  domain_name  = "ptre.es"
  domain_records = [
    ["A", "router.home", "10.0.2.1"],
    ["A", "nas.home", "10.0.2.11"],
    ["A", "beryl.home", "10.0.2.99"],
    ["A", "kermit.home", "10.0.2.16"],
    ["A", "elmo.home", "10.0.2.17"],
    ["A", "shell.home", "10.0.2.20"],
    ["A", "hass.home", "10.0.2.23"],
    ["A", "plex.home", "10.0.2.24"],
    ["A", "labs", "10.0.2.141"],
    ["A", "rs1", "188.40.139.188"],

  ]
  seckey_cloudflare_api_token = "CLOUDFLARE_API_TOKEN"
}
