variable "ssh_public_key" {}

variable "vsphere_server" {}
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_datacenter" {}
variable "vsphere_cluster" {}
variable "vsphere_datastore" {}
variable "vsphere_host" {}
variable "name" {}
variable "appdir" {}
variable "app" {}

variable "network_id" {}
variable "cpus" {}
variable "memory" {}
variable "fcos_vm_template" {}
variable "guest_type" {}

variable "traffic" {
  type = bool
  default = false
}
variable "fqdn" {
  type = string
  default = ""
}
