variable "account_name" {
  description = "Account Name"
  type        = string
}

variable "application_name" {
  description = "Application Name"
  type        = string
}

variable "zone" {
  description = "Zone"
  type        = any
}

variable "session_duration" {
  description = "Session Duration"
  type        = string
  default     = "6h"
}

variable "seckey_cloudflare_api_token" {
  description = "Secret Key for Cloudflare API Token"
  type        = string
}
