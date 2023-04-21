resource "vsphere_virtual_machine" "vm" {
  name             = var.name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id
  host_system_id   = data.vsphere_host.host.id

  num_cpus = var.cpus
  memory   = var.memory
  guest_id = var.guest_type

  network_interface {
    network_id   = var.network_id
  }

  disk {
    label            = "disk0"
    size             = 16
    eagerly_scrub    = false
    #  thin_provisioned = false
  }

  #ovf_deploy {
  #  allow_unverified_ssl_cert = true
  #  local_ovf_path            = var.fcos_ova_image
  #
  #  disk_provisioning = "thin"
  #
  #  ovf_network_map = {
  #    "Network 1" = var.network_id
  #  }
  #}
  clone {
    template_uuid = data.vsphere_virtual_machine.template[0].id
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
