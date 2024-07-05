terraform {
  required_version = ">= 1.5"
}

provider "cloudflare" {
  api_token = data.infisical_secrets.secrets.secrets[var.seckey_cloudflare_api_token].value
}

resource "cloudflare_zone" "zone" {
  zone       = var.domain_name
  account_id = var.account.id
}

resource "cloudflare_record" "records" {
  # [[type, name, value]]
  for_each = { for idx, record in var.domain_records : idx => record }
  zone_id  = cloudflare_zone.zone.id
  type     = each.value[0]
  name     = each.value[1]
  value    = each.value[2]
  ttl      = var.ttl
}

resource "cloudflare_record" "records_wildcard" {
  # [[type, name, value]]
  for_each = { for idx, record in var.domain_records : idx => record }
  zone_id  = cloudflare_zone.zone.id
  type     = each.value[0]
  name     = "*.${each.value[1]}"
  value    = each.value[2]
  ttl      = var.ttl
}
