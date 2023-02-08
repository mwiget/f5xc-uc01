resource "volterra_healthcheck" "frontend" {
  depends_on = [null_resource.next]
  name      = format("%s-frontend", var.project_prefix)
  namespace = var.f5xc_namespace

  http_health_check {
    use_origin_server_name = true
    path                   = "/"
  }
  healthy_threshold   = 1
  interval            = 15
  timeout             = 1
  unhealthy_threshold = 2
}

resource "volterra_origin_pool" "frontend" {
  depends_on = [null_resource.next]
  name                   = format("%s-frontend", var.project_prefix)
  namespace              = var.f5xc_namespace
  endpoint_selection     = "DISTRIBUTED"
  loadbalancer_algorithm = "LB_OVERRIDE"
  port                   = 80
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

  dynamic "origin_servers" {
    for_each = {for workload in module.wl-us-east-1 : workload.instance.tags.Name => workload}
    content {
      private_ip {
        ip = origin_servers.value.instance.private_ip
        outside_network = false
        inside_network = true
        site_locator {
          site {
            name = format("%s-tgw2", var.project_prefix)
            namespace = "system"
          }
        }
      }
    }
  }

  dynamic "origin_servers" {
    for_each = {for workload in module.wl-westus2 : workload.instance.name => workload}
    content {
      private_ip {
        ip = origin_servers.value.instance.private_ip
        outside_network = false
        inside_network = true
        site_locator {
          site {
            name = format("%s-vnet1", var.project_prefix)
            namespace = "system"
          }
        }
      }
    }
  }

  healthcheck {
    name = volterra_healthcheck.frontend.name
  }
}

resource "volterra_http_loadbalancer" "frontend" {
  depends_on = [null_resource.next]
  name                            = format("%s-frontend", var.project_prefix)
  namespace                       = var.f5xc_namespace
  no_challenge                    = true
  domains                         = [ "frontend.corp" ]

  disable_rate_limit              = true
  service_policies_from_namespace = true
  disable_waf                     = true
  source_ip_stickiness            = true

  advertise_custom {
    advertise_where {
      port = 80
      site {
        ip = "10.10.10.10"
        network = "SITE_NETWORK_INSIDE"
        site {
          name      = format("%s-tgw1", var.project_prefix)
          namespace = "system"
        }
      }
    }
    advertise_where {
      port = 80
      site {
        ip = "10.10.10.10"
        network = "SITE_NETWORK_INSIDE"
        site {
          name      = format("%s-tgw2", var.project_prefix)
          namespace = "system"
        }
      }
    }
    advertise_where {
      port = 80
      site {
        ip = "10.10.10.10"
        network = "SITE_NETWORK_INSIDE"
        site {
          name      = format("%s-vnet1", var.project_prefix)
          namespace = "system"
        }
      }
    }
  }

  default_route_pools {
    pool {
      name = volterra_origin_pool.frontend.name
    }
    weight = 1
    priority = 1
  }

  http {
    dns_volterra_managed = false
    port = 80
  }
}

