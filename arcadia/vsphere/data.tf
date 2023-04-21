data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  name          = var.vsphere_host
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "ds" {
  name = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "ct_config" "workload" {
  content = templatefile("./templates/fcos_arcadia_vsphere.yaml", {
    appdir = var.appdir,
    app = var.app,
    traffic = var.traffic,
    fqdn = var.fqdn,
    ssh_public_key = var.ssh_public_key
  })
  strict = true
}

data "vsphere_virtual_machine" "template" {
  count = var.fcos_vm_template == "" ? 0 : 1
  name = var.fcos_vm_template
  datacenter_id = data.vsphere_datacenter.dc.id
} 
