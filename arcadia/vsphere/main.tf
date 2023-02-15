resource "vsphere_virtual_machine" "vm" {
  name             = var.name
  datacenter_id    = data.vsphere_datacenter.dc.id
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id
  host_system_id   = data.vsphere_host.host.id

  num_cpus = var.cpus
  memory   = var.memory

  network_interface {
    network_id   = var.network_id
  }

  disk {
    label            = "disk0"
    size             = 16
    eagerly_scrub    = false
    #  thin_provisioned = false
  }

  ovf_deploy {
    allow_unverified_ssl_cert = true
    local_ovf_path            = var.fcos_ova_image

    disk_provisioning = "thin"

    ovf_network_map = {
      "Network 1" = var.network_id
    }
  }

  vapp {
    properties = {
      "guestinfo.ignition.config.data" = data.ct_config.workload.rendered
    }
  }
}

output "instance" {
  value = vsphere_virtual_machine.vm
}
