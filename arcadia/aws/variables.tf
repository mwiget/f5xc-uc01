variable "subnet_name" {
  type  = string
}
variable "site_name" {
  type  = string
}
variable "subnet_id" {
  type  = string
}
variable "ssh_public_key" {
  type  = string
}
variable "vpc_id" {
  type  = string
}
variable "availability_zone" {
  type        = string
}
variable "instance_type" {
  type  = string
  default = "t3.nano"
}
variable "owner_tag" {
  type        = string
  default     = "m.wiget@f5.com"
}
variable "security_group_id" {
  type        = string
}

variable "deployment" {
  type = string
}
variable "appdir" {
  type = string
}
variable "fqdn" {
  type = string
  default = ""
}
variable "app" {
  type = string
}
variable "traffic" {
  type = bool
  default = false
}
