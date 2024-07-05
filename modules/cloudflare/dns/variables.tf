variable "account" {
  description = "Cloudflare Account"
  type        = any
}

variable "domain_name" {
  description = "Domain Name"
  type        = string
}

variable "domain_records" {
  type    = list(list(string))
  default = []
}

variable "ttl" {
  description = "TTL"
  type        = number
  default     = 3600
}

variable "seckey_cloudflare_api_token" {
  description = "Secret Key for Cloudflare API Token"
  type        = string
}
