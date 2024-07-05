variable "zone" {
  description = "Cloudflare Zone"
  type = any
}

variable "applications" {
  description = "Applications"
  type        = list
}


variable "seckey_cloudflare_api_token" {
  description = "Secret Key for Cloudflare API Token"
  type        = string
}
