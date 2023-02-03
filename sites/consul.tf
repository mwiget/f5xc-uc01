module "namespace_consul" {
  source              = "./modules/f5xc/namespace"
  f5xc_namespace_name = format("%s-consul", var.project_prefix)
}

module "virtual_site_consul" {
  source                                = "./modules/f5xc/site/virtual"
  f5xc_namespace                        = "shared"
  f5xc_virtual_site_name                = format("%s-consul", var.project_prefix)
  f5xc_virtual_site_type                = "CUSTOMER_EDGE"
  f5xc_virtual_site_selector_expression = [ format("site-mesh in (%s)", var.project_prefix) ]
}

module "vk8s_consul" {
  source                     = "./modules/f5xc/v8ks"
  f5xc_tenant                = var.f5xc_tenant
  f5xc_api_url               = var.f5xc_api_url
  f5xc_api_token             = var.f5xc_api_token
  f5xc_vk8s_name             = format("%s-consul", var.project_prefix)
  f5xc_virtual_k8s_namespace = module.namespace_consul.namespace["name"]
  f5xc_create_k8s_creds      = true
  f5xc_k8s_credentials_name  = format("%s-vk8s-consul-creds", var.project_prefix)
  f5xc_virtual_site_refs     = [module.virtual_site_consul.virtual-site["name"]]
  f5xc_vsite_refs_namespace  = "shared"
}


output "namespace_consul" {
  value = module.namespace_consul
}

output "kube_config" {
  value     = module.vk8s_consul.vk8s["k8s_conf"]
  sensitive = true
}

resource "local_file" "kubeconfig" {
  content  = module.vk8s_consul.vk8s["k8s_conf"]
  filename = "./.kube/config"
}

resource "kubernetes_deployment" "consul" {
  provider = kubernetes.lke
  metadata {
    name = "consul"
    namespace = format("%s-consul", var.project_prefix)
    labels = {
      app = "consul"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "consul"
      }
    }

    template {
      metadata {
        labels = {
          app = "consul"
        }
      }

      spec {
        container {
          image = "consul:latest"
          name  = "consul"
          env {
            name  = "CONSUL_BIND_INTERFACE"
            value = "eth0"
          }
          env {
            name  = "CONSUL_LOCAL_CONFIG"
           value = format("{\"datacenter\": \"%s\"}", var.project_prefix)
          }
          port {
            container_port = 8500
          }
          # resources {
          #  limits = {
          #    cpu    = "0.5"
          #    memory = "512Mi"
          #  }
          #  requests = {
          #    cpu    = "250m"
          #    memory = "50Mi"
          #  }
          # }

          liveness_probe {
           http_get {
             path = "/v1/agent/checks"
             port = 8500
          
             http_header {
               name  = "X-Custom-Header"
               value = "Awesome"
             }
           }
           initial_delay_seconds = 3
           period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "consul" {
  provider = kubernetes.lke
  metadata {
    name = "consul"
    namespace = format("%s-consul", var.project_prefix)
  }
  spec {
    selector = {
      app = kubernetes_deployment.consul.metadata.0.labels.app
    }
    session_affinity = "None"
    port {
      name        = "rpc"
      port        = 8400
      target_port = 8400
    }
    port {
      name        = "http"
      port        = 8500
      target_port = 8500
    }
    port {
      name        = "dns"
      port        = 8600
      target_port = 8600
    }

    type = "ClusterIP"
  }
}

resource "volterra_healthcheck" "consul" {
  name      = format("%s-consul", var.project_prefix)
  namespace = format("%s-consul", var.project_prefix)

  http_health_check {
    use_origin_server_name = true
    path                   = "/v1/agent/checks"
  }
  healthy_threshold   = 1
  interval            = 15
  timeout             = 1
  unhealthy_threshold = 2
}

resource "volterra_origin_pool" "consul-http" {
  name                   = format("%s-consul", var.project_prefix)
  namespace              = format("%s-consul", var.project_prefix)
  endpoint_selection     = "LOCAL_ONLY"
  loadbalancer_algorithm = "LB_OVERRIDE"
  port                   = 8500
  no_tls                 = true

  origin_servers {
    k8s_service {
      service_name = format("consul.%s-consul", var.project_prefix)
      site_locator {
        virtual_site {
          namespace = "shared"
          name      = module.virtual_site_consul.virtual-site["name"]
        }
      }
      vk8s_networks = true
    }
  }

  healthcheck {
    name = volterra_healthcheck.consul.name
  }
}

resource "volterra_http_loadbalancer" "consul-http" {
  name                            = format("%s-consul", var.project_prefix)
  namespace                       = format("%s-consul", var.project_prefix)
  no_challenge                    = true
  domains                         = [ "http.consul" ]

  disable_rate_limit              = true
  service_policies_from_namespace = true
  disable_waf                     = true
  source_ip_stickiness            = true

  advertise_custom {
    advertise_where {
      port = 8500
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
      port = 8500
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
      port = 8500
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
      name = volterra_origin_pool.consul-http.name
    }
    weight = 1
    priority = 1
  }

  http {
    dns_volterra_managed = false
    port = 8500
  }

  depends_on = [ volterra_origin_pool.consul-http ]
}

resource "volterra_discovery" "consul" {
  name      = format("%s-consul", var.project_prefix)
  namespace = "system"
  no_cluster_id = true
  discovery_consul {
    access_info {
      connection_info {
        api_server = "http://10.10.10.10:8500"
      }

    }
    publish_info {
      disable = true
    }
  }
  where {
    virtual_site {
      network_type = "SITE_NETWORK_INSIDE"
      ref {
        name      = module.virtual_site_consul.virtual-site["name"]
        namespace = "shared"
      }
    }
  }
}

