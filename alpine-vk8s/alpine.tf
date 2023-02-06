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
          command = [ "sh", "-c", "apk add curl && sleep infinity" ]
        }
      }
    }
  }
}

