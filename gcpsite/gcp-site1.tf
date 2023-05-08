module "gcp1" {
  source                            = "./modules/f5xc/site/gcp"
  f5xc_tenant                       = var.f5xc_tenant
  f5xc_api_url                      = var.f5xc_api_url
  f5xc_gcp_cred                     = var.f5xc_gcp_cred
  f5xc_api_token                    = var.f5xc_api_token
  f5xc_namespace                    = "system"
  f5xc_gcp_region                   = "europe-west6"
  f5xc_gcp_site_name                = format("%s-gcp1", var.project_prefix)
  f5xc_gcp_zone_names               = ["europe-west6-a", "europe-west6-b"]
  f5xc_gcp_ce_gw_type               = "multi_nic"
  f5xc_gcp_node_number              = 3
  f5xc_gcp_outside_network_name     = format("%s-gcp1-outside", var.project_prefix)
  f5xc_gcp_outside_subnet_name      = format("%s-gcp1-outside", var.project_prefix)
  f5xc_gcp_inside_network_name      = format("%s-gcp1-inside", var.project_prefix)
  f5xc_gcp_inside_subnet_name       = format("%s-gcp1-inside", var.project_prefix)
  f5xc_gcp_outside_primary_ipv4     = "10.102.32.0/24"
  f5xc_gcp_inside_primary_ipv4      = "10.102.33.0/24"
  f5xc_gcp_default_ce_sw_version    = true
  f5xc_gcp_default_ce_os_version    = true
  f5xc_gcp_default_blocked_services = true
  ssh_public_key                    = var.ssh_public_key
  providers = {
    google = google.europe-west6
  }
}

output "gcp1" {
  value = module.gcp1.gcp_vpc
}
