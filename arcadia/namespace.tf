resource "volterra_namespace" "namespace" {
  name = var.f5xc_namespace
}

resource "time_sleep" "wait_10_seconds" {
  depends_on      = [volterra_namespace.namespace]
  create_duration = "10s"
}

resource "null_resource" "next" {
  depends_on = [time_sleep.wait_10_seconds]
}

