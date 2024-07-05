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
  domain_name  = "ptre.net"
  domain_records = [
    # ["A", "test", "1.1.1.1"]
  ]
  seckey_cloudflare_api_token = "CLOUDFLARE_API_TOKEN"
}
