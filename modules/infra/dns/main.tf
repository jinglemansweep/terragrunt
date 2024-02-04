provider "cloudflare" {
  api_token = data.infisical_secrets.secrets.secrets["CLOUDFLARE_API_TOKEN"]
}

output "cloudflare_api_token" {
  value = data.infisical_secrets.secrets.secrets["CLOUDFLARE_API_TOKEN"]
}
