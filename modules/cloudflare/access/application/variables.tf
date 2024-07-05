variable "zone" {
  description = "Cloudflare Zone"
  type = any
}

variable "applications" {
  description = "Applications"
  type        = list
}

variable "tunnel_cname" {
  description = "Cloudflare Tunnel CNAME"
  type = string
}

variable "seckey_cloudflare_api_token" {
  description = "Secret Key for Cloudflare API Token"
  type        = string
}
