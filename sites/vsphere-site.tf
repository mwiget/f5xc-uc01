module "vsphere1" {
  source                 = "./vsphere"
  f5xc_tenant            = var.f5xc_tenant
  f5xc_api_url           = var.f5xc_api_url
  f5xc_namespace         = var.f5xc_namespace
  f5xc_api_token         = var.f5xc_api_token
  project_prefix         = var.project_prefix

  xcsovapath             = var.f5xc_ova_image
  vsphere_user           = var.vsphere_user
  vsphere_password       = var.vsphere_password
  vsphere_server         = var.vsphere_server
  vsphere_datacenter     = var.vsphere_datacenter
  vsphere_cluster        = var.vsphere_cluster
  nodes   = [
    { name = "master-0", host = "192.168.40.100", datastore = "datastore1", ipaddress = "192.168.40.31/24" }
    #    { name = "master-1", host = "192.168.40.100", datastore = "datastore1", ipaddress = "192.168.40.32/24" },
    #{ name = "master-2", host = "192.168.40.100", datastore = "datastore1", ipaddress = "192.168.40.33/24" }
  ]
  outside_network        = "VM Network"
  dnsservers             = {
    primary = "8.8.8.8"
    secondary = "4.4.4.4"
  }
  publicdefaultgateway   = "192.168.40.1"
  publicdefaultroute     = "0.0.0.0/0"
  guest_type             = "other3xLinux64Guest"
  cpus                   = 4
  memory                 = 16384
  certifiedhardware      = "vmware-voltmesh"
  cluster_name           = format("%s-vsphere1", var.project_prefix)
  sitetoken              = volterra_token.token.id
  sitelatitude           = "47"
  sitelongitude          = "8.5"
  cluster_size           = 1  # set to 3 for 3-node cluster !!!
  ssh_public_key         = var.ssh_public_key
}

resource "volterra_token" "token" {
  name = format("%s-token", var.project_prefix)
  namespace = "system"
}

output "vm" {
  value = module.vsphere1
}
