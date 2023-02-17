resource "volterra_tcp_loadbalancer" "iperf3-tgw1" {
  depends_on = [null_resource.next]
  name                 = format("%s-iperf3-tgw1", var.project_prefix)
  namespace            = var.f5xc_namespace
  domains              = [ "iperf3" ]
  labels               = local.labels

  listen_port          = 5201

  advertise_custom {
    advertise_where {
      port = 5201
      site {
        ip = "10.10.10.11"
        network = "SITE_NETWORK_INSIDE"
        site {
          name      = format("%s-tgw1", var.project_prefix)
          namespace = "system"
        }
      }
    }
    advertise_where {
      port = 5201
      site {
        ip = "10.10.10.11"
        network = "SITE_NETWORK_INSIDE"
        site {
          name      = format("%s-tgw2", var.project_prefix)
          namespace = "system"
        }
      }
    }
    advertise_where {
      port = 5201
      site {
        ip = "10.10.10.11"
        network = "SITE_NETWORK_INSIDE"
        site {
          name      = format("%s-vnet1", var.project_prefix)
          namespace = "system"
        }
      }
    }
    advertise_where {
      port = 5201
      site {
        ip = "10.10.10.11"
        network = "SITE_NETWORK_OUTSIDE"
        site {
          name      = format("%s-vsphere1", var.project_prefix)
          namespace = "system"
        }
      }
    }
  }

  origin_pools_weights {
    pool {
      name = volterra_origin_pool.iperf3-tgw1.name
    } 
    weight = 1
  }
  do_not_advertise               = false
  hash_policy_choice_round_robin = true
} 

resource "volterra_origin_pool" "iperf3-tgw1" {
  depends_on = [null_resource.next]
  name                   = format("%s-iperf3-tgw1", var.project_prefix)
  namespace              = var.f5xc_namespace
  endpoint_selection     = "DISTRIBUTED"
  loadbalancer_algorithm = "LB_OVERRIDE"
  port                   = 5201
  no_tls                 = true

  dynamic "origin_servers" {
    for_each = {for workload in module.wl-us-west-2 : workload.instance.tags.Name => workload}
    content {
      private_ip {
        ip = origin_servers.value.instance.private_ip
        outside_network = false
        inside_network = true
        site_locator {
          site {
            name = format("%s-tgw1", var.project_prefix)
            namespace = "system"
          }
        }
      }
    }
  }

  healthcheck {
    name = volterra_healthcheck.hc.name
  }
}

