include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules//cloudflare/dns"
}

inputs = {
  account_name                = "Personal Account"
  domain_name                 = "ptre.uk"
  domain_records              = []
  seckey_cloudflare_api_token = "CLOUDFLARE_API_TOKEN"
}
