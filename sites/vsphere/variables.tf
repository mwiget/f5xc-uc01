variable "project_prefix" {}
variable "f5xc_tenant" {}
variable "f5xc_api_url" {}
variable "f5xc_namespace" {}
variable "f5xc_api_token" {}
variable "ssh_public_key" {}

variable "vsphere_server" {}
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_datacenter" {}
variable "vsphere_cluster" {}

variable "nodes" {
  type = list(object({
    name      = string
    datastore = string
    ipaddress = string
    host      = string
  }))
}

variable "outside_network" {}
variable "publicdefaultgateway" {}
variable "dnsservers" {}
variable "cpus" {}
variable "memory" {}
variable "xcsovapath" {}

variable "certifiedhardware" {}
variable "publicdefaultroute" {}
variable "cluster_name" {}
variable "sitetoken" {}
variable "guest_type" {}
variable "sitelatitude" {}
variable "sitelongitude" {}
variable "cluster_size" {}
