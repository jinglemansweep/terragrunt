terraform {
  required_version = ">= 1.5"
}

provider "cloudflare" {
  api_token = data.infisical_secrets.secrets.secrets[var.seckey_cloudflare_api_token].value
}



resource "cloudflare_access_application" "application" {
  for_each = { for idx, record in var.applications : record.name => record }
  name             = each.value.name
  zone_id          = each.value.zone.id
  domain           = "${each.value.subdomain}.${each.value.zone.zone}"
  # tags             = lookup(each.value, "tags", [])
  session_duration = lookup(each.value, "session_duration", "60m")
  logo_url = lookup(each.value, "logo_url", null)
}

resource "cloudflare_access_policy" "access_policy_lan" {
  for_each = { for idx, record in var.applications : record.name => record }
  zone_id     = each.value.zone.id
  application_id = "${ cloudflare_access_application.application[each.value.name].id }"
  name           = "LAN Bypass Policy"
  precedence     = "1"
  decision       = "bypass"
  include {
    ip = ["62.3.65.60/32", "10.1.1.10/24"]
  }
  depends_on = [
    cloudflare_access_application.application
  ]
}

resource "cloudflare_access_policy" "access_policy_users" {
  for_each = { for idx, record in var.applications : record.name => record }
  zone_id     = each.value.zone.id
  application_id = "${ cloudflare_access_application.application[each.value.name].id }"
  name           = "User Include Policy"
  precedence     = "2"
  decision       = "allow"
  include {
    group = ["6698d834-9b68-4c7f-bcd0-64dccc1f3987"] # "Users" Group ID
  }
  depends_on = [
    cloudflare_access_application.application
  ]
}