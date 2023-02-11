resource "volterra_app_type" "arcadia" {
  name      = format("%s-arcadia", var.project_prefix)
  namespace = "shared"
}
