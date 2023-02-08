variable "vnet_name" {
  type    = string
}

variable "azure_region" {
  type    = string
}

variable "azure_az" {
  type    = string
}

variable "vnet_cidr_block" {
  type    = string
}

variable "vnet_subnet_cidr_block" {
  type    = string
}

variable "custom_tags" {
  type    = map(string)
  default = {}
}

variable "ssh_public_key" {
  type    = string
}

variable "bastion_cidr" {
  type = string
  default = "0.0.0.0/0"
}
