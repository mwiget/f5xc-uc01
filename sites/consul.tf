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
          # env {
          #   name  = "CONSUL_LOCAL_CONFIG"
          #  value = '{"datacenter": "mwadn-prod"}'
          # }
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

          # liveness_probe {
          #  http_get {
          #    path = "/"
          #    port = 80
          # 
          #    http_header {
          #      name  = "X-Custom-Header"
          #      value = "Awesome"
          #    }
          #  }
          # 
          #  initial_delay_seconds = 3
          #  period_seconds        = 3
          # }
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
      port        = 8500
      target_port = 8500
    }

    type = "ClusterIP"
  }
}


