output "domain_name" {
  value = var.domain_name
}

output "cloudflare_api_token" {
  value     = data.infisical_secrets.secrets.secrets[var.seckey_cloudflare_api_token].value
  sensitive = true
}

output "seckey_cloudflare_api_token" {
  value = var.seckey_cloudflare_api_token
}
