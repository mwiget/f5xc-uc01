resource "restapi_object" "secure_mesh_site_2" {
  id_attribute = "metadata/name"
  path         = "/config/namespaces/system/securemesh_sites"
  data         = local.vsphere2
}

module "vsphere2" {
  source           = "./modules/f5xc/ce/vsphere"
  f5xc_tenant      = var.f5xc_tenant
  f5xc_api_url     = var.f5xc_api_url
  f5xc_namespace   = var.f5xc_namespace
  f5xc_api_token   = var.f5xc_api_token
  f5xc_api_ca_cert = var.f5xc_api_ca_cert
  f5xc_reg_url     = var.f5xc_reg_url
  # f5xc_ova_image         = var.f5xc_ova_image
  f5xc_vm_template   = var.f5xc_vm_template
  vsphere_user       = var.vsphere_user
  vsphere_password   = var.vsphere_password
  vsphere_server     = var.vsphere_server
  vsphere_datacenter = var.vsphere_datacenter
  vsphere_cluster    = var.vsphere_cluster

  # F5 SJC lab
  nodes = [
    { name = "master-0", host = "10.200.0.100", datastore = "datastore-esxi-1", ipaddress = "dhcp" },
    { name = "master-1", host = "10.200.0.100", datastore = "datastore-esxi-1", ipaddress = "dhcp" },
    { name = "master-2", host = "10.200.0.100", datastore = "datastore-esxi-1", ipaddress = "dhcp" }
  ]
  outside_network = "VM Network"
  inside_network  = "vela-inside"

  dnsservers = {
    primary   = "8.8.8.8"
    secondary = "8.8.4.4"
  }
  # publicdefaultgateway   = "10.200.0.1"
  # publicdefaultroute = "0.0.0.0/0"
  guest_type        = "centos64Guest"
  cpus              = 4
  memory            = 16384
  certifiedhardware = "vmware-regular-nic-voltmesh"
  cluster_name      = format("%s-vsphere2", var.project_prefix)
  sitelatitude      = "37.4"
  sitelongitude     = "-121.9"
}

locals {
  vsphere2 = jsonencode({
    "metadata" : {
      "name" : format("%s-vsphere2", var.project_prefix)
      "namespace" : "system",
      "labels" : {
        "site-mesh" : var.project_prefix
      },
      "annotations" : {},
      "disable" : false
    },
    "spec" : {
      "volterra_certified_hw" : "vmware-regular-nic-voltmesh",
      "master_node_configuration" : [
        {
          "name" : "master-0"
        },
        {
          "name" : "master-1"
        },
        {
          "name" : "master-2"
        }
      ],
      "worker_nodes" : [],
      "no_bond_devices" : {},
      "custom_network_config" : {
        "default_config" : {},
        "sli_config" : {
          "labels" : {},
          "no_static_routes" : {},
          "no_dc_cluster_group" : {}
        },
        "interface_list" : {
          "interfaces" : [
            {
              "description" : "eth1",
              "labels" : {},
              "ethernet_interface" : {
                "device" : "eth1",
                "cluster" : {},
                "untagged" : {},
                "dhcp_server" : {
                  "dhcp_networks" : [
                    {
                      "network_prefix" : "10.102.0.0/24",
                      "pool_settings" : "INCLUDE_IP_ADDRESSES_FROM_DHCP_POOLS",
                      "pools" : [
                        {
                          "start_ip" : "10.102.0.10",
                          "end_ip" : "10.102.0.99",
                          "exclude" : false
                        }
                      ],
                      "first_address" : {},
                      "same_as_dgw" : {}
                    }
                  ],
                  "automatic_from_start" : {},
                  "fixed_ip_map" : {}
                },
                "site_local_inside_network" : {},
                "mtu" : 0,
                "priority" : 0,
                "not_primary" : {},
                "monitor_disabled" : {}
              }
            }
          ]
        },
        "no_network_policy" : {},
        "no_forward_proxy" : {},
        "no_global_network" : {},
        "vip_vrrp_mode" : "VIP_VRRP_INVALID",
        "tunnel_dead_timeout" : 0,
        "sm_connection_pvt_ip" : {}
      },
      "coordinates" : {
        "latitude" : 0,
        "longitude" : 0
      },
      "logs_streaming_disabled" : {},
      "default_blocked_services" : {},
      "offline_survivability_mode" : {
        "no_offline_survivability_mode" : {}
      }
    }
  })
}

output "secure_mesh_site_2" {
  value = restapi_object.secure_mesh_site_2.api_response
}

output "vsphere2" {
  value = module.vsphere2
}
