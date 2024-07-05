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
