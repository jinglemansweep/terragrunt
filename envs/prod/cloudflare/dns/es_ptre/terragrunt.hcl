include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules//cloudflare/dns"
}

dependency "account_home" {
  config_path = "../../accounts/home"
}

inputs = {
  account = dependency.account_home.outputs.account
  domain_name  = "ptre.es"
  domain_records = [
    ["A", "wan", "62.3.65.60"],
  ]
  seckey_cloudflare_api_token = "CLOUDFLARE_API_TOKEN"
}
