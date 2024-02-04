generate "provider_cloudflare" {
  path      = "_provider_cloudflare.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "cloudflare" {
  api_token = data.infisical_secrets.secrets["CLOUDFLARE_API_TOKEN"]
}
EOF
}


