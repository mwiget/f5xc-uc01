module "namespace" {
  source              = "./modules/f5xc/namespace"
  f5xc_namespace_name = var.project_prefix
}

module "virtual_site_service" {
  source                                = "./modules/f5xc/site/virtual"
  f5xc_namespace                        = "shared"
  f5xc_virtual_site_name                = var.project_prefix
  f5xc_virtual_site_type                = "CUSTOMER_EDGE"
  f5xc_virtual_site_selector_expression = [ format("site-mesh in (%s)", var.project_prefix) ]
}

module "vk8s_service" {
  source                     = "./modules/f5xc/v8ks"
  f5xc_tenant                = var.f5xc_tenant
  f5xc_api_url               = var.f5xc_api_url
  f5xc_api_token             = var.f5xc_api_token
  f5xc_vk8s_name             = var.project_prefix
  f5xc_virtual_k8s_namespace = module.namespace.namespace["name"]
  f5xc_create_k8s_creds      = true
  f5xc_k8s_credentials_name  = format("%s-vk8s-creds", var.project_prefix)
  f5xc_virtual_site_refs     = [module.virtual_site_service.virtual-site["name"]]
  f5xc_vsite_refs_namespace  = "shared"
}


output "namespace" {
  value = module.namespace
}

output "kube_config" {
  value     = module.vk8s_service.vk8s["k8s_conf"]
  sensitive = true
}

resource "local_file" "kubeconfig" {
  content  = module.vk8s_service.vk8s["k8s_conf"]
  filename = "./kubeconfig"
}

