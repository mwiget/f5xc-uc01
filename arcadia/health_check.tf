resource "volterra_healthcheck" "hc" {
  depends_on = [null_resource.next]
  name      = format("%s-hc", var.project_prefix)
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
