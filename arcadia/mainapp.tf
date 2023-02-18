resource "volterra_http_loadbalancer" "public" {
  name                            = format("%s-public", var.project_prefix)
  namespace                       = var.f5xc_namespace
  domains                         = [var.fqdn]
  labels                          = local.labels

  advertise_on_public_default_vip = true
  no_challenge                    = true
  disable_rate_limit              = true
  disable_waf                     = true
  round_robin                     = true
  no_service_policies             = true
  multi_lb_app                    = true

  https_auto_cert {
    add_hsts      = true
    http_redirect = true
    no_mtls       = true
  }
  
  app_firewall {
    name        = "default"
    namespace   = "shared"
  }

  routes {
    simple_route {
      http_method = "ANY"
      path {
        prefix = "/api"
      }
      origin_pools {
        pool {
          name = volterra_origin_pool.app2.name
        }
        weight = 1
        priority = 1
      }
    }
  }

  routes {
    simple_route {
      http_method = "ANY"
      path {
        prefix = "/app3"
      }
      origin_pools {
        pool {
          name = volterra_origin_pool.app3.name
        }
        weight = 1
        priority = 1
      }
    }
  }

  routes {
    simple_route {
      http_method = "ANY"
      path {
        prefix = "/"
      }
      origin_pools {
        pool {
          name = volterra_origin_pool.mainapp.name
        }
        weight = 1
        priority = 1
      }
    }
  }
  depends_on = [ volterra_origin_pool.mainapp ]
}

resource "volterra_origin_pool" "mainapp" {
  depends_on = [null_resource.next]
  name                   = format("%s-mainapp", var.project_prefix)
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

  healthcheck {
    name = volterra_healthcheck.hc.name
  }
}

