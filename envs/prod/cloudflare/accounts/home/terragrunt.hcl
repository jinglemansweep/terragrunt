include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules//cloudflare/account"
}

inputs = {
  account_name = "Personal Account"
  seckey_cloudflare_api_token = "CLOUDFLARE_API_TOKEN"
}
