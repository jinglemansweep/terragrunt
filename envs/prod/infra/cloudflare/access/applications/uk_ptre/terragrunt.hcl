include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules//cloudflare/access/application"
}

dependency "zone" {
  config_path = "../../../../dns/zones/uk_ptre"
}

inputs = {
  account_name                = "Personal Account"
  application_name            = "ptre.uk"
  zone                        = dependency.zone.outputs.zone
  seckey_cloudflare_api_token = "CLOUDFLARE_API_TOKEN"
}
