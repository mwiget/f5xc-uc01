resource "kubernetes_deployment" "alpine" {
  metadata {
    name = "alpine"
    namespace = var.project_prefix
    labels = {
      app = "alpine"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "alpine"
      }
    }

    template {
      metadata {
        labels = {
          app = "alpine"
        }
      }

      spec {
        container {
          image = "alpine:latest"
          name  = "alpine"
          command = [ "sh", "-c", "apk add fping curl openssh && echo '10.10.10.10 frontend.corp backend.corp' >> /etc/hosts && sleep infinity" ]
          volume_mount {
            name = "sshkey"
            mount_path = "/root/.ssh/"
          }
        }
        volume {
          name = "sshkey"
          config_map {
            name = "ssh-private-key"
            default_mode = "0600"
          }
        }
      }
    }
  }
}

resource "kubernetes_config_map" "ssh_priv_key" {
  metadata {
    name = "ssh-private-key"
    namespace = var.project_prefix
  }
  data = {
    "id_rsa" = file("../id_rsa")
  }
}

