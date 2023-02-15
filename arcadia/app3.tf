resource "volterra_origin_pool" "app3" {
  depends_on = [null_resource.next]
  name                   = format("%s-app3", var.project_prefix)
  namespace              = var.f5xc_namespace
  endpoint_selection     = "DISTRIBUTED"
  loadbalancer_algorithm = "LB_OVERRIDE"
  port                   = 80
  no_tls                 = true

  dynamic "origin_servers" {
    for_each = {for workload in module.wl-vsphere1 : workload.instance.name => workload}
    content {
      private_ip {
        ip = origin_servers.value.instance.default_ip_address
        outside_network = true
        inside_network = false
        site_locator {
          site {
            name = format("%s-vsphere1", var.project_prefix)
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

