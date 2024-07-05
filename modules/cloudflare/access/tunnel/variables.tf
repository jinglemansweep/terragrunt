variable "account" {
  description = "Account"
  type        = any
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
  }))
}
