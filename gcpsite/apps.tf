module "apps1" {
  count          = 1
  source         = "./apps"
  namespace      = volterra_namespace.ns.name
  name           = format("%s-app1", var.project_prefix)
  domains        = ["workload.apps1"]
  advertise_port = 80
  origin_port    = 8080
  origin_servers = {
    format("%s-gcp1", var.project_prefix) : { ip = resource.google_compute_instance.workload.network_interface[0].network_ip }
  }
  advertise_vip = "10.10.10.10"
  advertise_sites = [
    format("%s-gcp1", var.project_prefix)
  ]
  depends_on = [module.gcp1]
}
