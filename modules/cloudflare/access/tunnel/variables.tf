variable "account_name" {
  description = "Account Name"
  type        = string
}

variable "team_name" {
  description = "Team Name"
  type        = string
}

variable "tunnel_name" {
  description = "Tunnel Name"
  type        = string
}

variable "tunnel_ingress_rules" {
  description = "Tunnel Ingress Rules"
  type = list(object({
    hostname      = string
    service       = string
    access        = bool
    audience_tags = list(string)
  }))
}

variable "seckey_cloudflare_api_token" {
  description = "Secret Key for Cloudflare API Token"
  type        = string
}

variable "seckey_tunnel_secret" {
  description = "Secret Key for Tunnel Secret"
  type        = string
}
