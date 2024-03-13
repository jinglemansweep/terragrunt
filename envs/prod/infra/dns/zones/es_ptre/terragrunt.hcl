include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules//cloudflare/dns"
}

inputs = {
  account_name = "Personal Account"
  domain_name  = "ptre.es"
  domain_records = [
    ["A", "labs", "10.1.1.141"],
    ["A", "rs1", "188.40.139.188"],
    ["A", "rs1.ts", "100.122.54.59"],
  ]
  seckey_cloudflare_api_token = "CLOUDFLARE_API_TOKEN"
}
