variable "host" {
  type = string
}

variable "port" {
  type = number
}

variable "username" {
  type = string
}

variable "password" {
  type = string
  sensitive = true
}

variable "databases" {
  type = list(string)

  default = [
    "identity_db",
    "vault_db",
    "safety_db",
    "family_persona_db",
    "tenant_billing_db",
    "control_plane_db"
  ]
}
