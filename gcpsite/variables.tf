variable "project_prefix" {
  type    = string
  default = "f5xc"
}

variable "deployment" {
  type    = string
  default = "f5xc"
}

variable "owner_tag" {
  type    = string
  default = "user@email"
}

variable "f5xc_api_p12_file" {
  type = string
}

variable "f5xc_api_url" {
  type = string
}

variable "f5xc_api_token" {
  type = string
}

variable "f5xc_api_ca_cert" {
  type    = string
  default = ""
}

variable "f5xc_tenant" {
  type = string
}

variable "f5xc_namespace" {
  type    = string
  default = "system"
}

variable "ssh_public_key" {
  type = string
}

variable "f5xc_gcp_cred" {
  type = string
}
variable "gcp_project_id" {
  type = string
}

#variable "VES_P12_PASSWORD" {
#  type    = string
#  description = "required to slience warning in terraform cloud for env var used to decrypt f5xc_api_p12_file"
#}

variable "bastion_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "f5xc_reg_url" {
  type    = string
  default = "ves.volterra.io"
}

variable "admin_password" {
  type    = string
  default = ""
}

variable "maurice_endpoint" {
  type    = string
  default = "https://register.ves.volterra.io"
}

variable "maurice_mtls_endpoint" {
  type    = string
  default = "https://register-tls.ves.volterra.io"
}

variable "tailscale_key" {
  type = string
  default = ""
}
