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
  content = templatefile("./templates/fcos_iperf3_vsphere.yaml", {
    ssh_public_key = var.ssh_public_key
  })
  strict = true
}
