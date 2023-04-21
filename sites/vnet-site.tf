module "vnet1" {
  source                              = "./modules/f5xc/site/azure"
  f5xc_namespace                      = "system"
  f5xc_tenant                         = var.f5xc_tenant
  f5xc_azure_cred                     = var.f5xc_azure_cred
  f5xc_azure_region                   = "westus2"
  f5xc_api_url                        = var.f5xc_api_url
  f5xc_api_token                      = var.f5xc_api_token
  f5xc_azure_site_name                = format("%s-vnet1", var.project_prefix)
  f5xc_azure_vnet_site_resource_group = format("%s-vnet1-rg", var.project_prefix)
  f5xc_azure_vnet_primary_ipv4        = "10.101.0.0/24"
  f5xc_azure_ce_gw_type               = "multi_nic"
  f5xc_azure_az_nodes                 = {
    node0 : {
      f5xc_azure_az                  = "1", 
      f5xc_azure_vnet_inside_subnet  = "10.101.0.0/26",
      f5xc_azure_vnet_outside_subnet = "10.101.0.64/26"
    }
    node1 : {
      f5xc_azure_az                  = "2", 
      f5xc_azure_vnet_inside_subnet  = "10.101.0.0/26",
      f5xc_azure_vnet_outside_subnet = "10.101.0.64/26"
    }
    node2 : {
      f5xc_azure_az                  = "3", 
      f5xc_azure_vnet_inside_subnet  = "10.101.0.0/26",
      f5xc_azure_vnet_outside_subnet = "10.101.0.64/26"
    }
  }
  f5xc_azure_hub_spoke_vnets          = [
    {
      resource_group                  = module.spoke_vnet_a.resource_group.resource_group.name
      vnet_name                       = module.spoke_vnet_a.vnet.name
      auto                            = true
      manual                          = false
      labels                          = {}
    },
    {
      resource_group                  = module.spoke_vnet_b.resource_group.resource_group.name
      vnet_name                       = module.spoke_vnet_b.vnet.name
      auto                            = true
      manual                          = false
      labels                          = {}
    }
  ]
  f5xc_azure_express_route_connections = [
    {
      name                            = "solution-team"
      description                     = "connection into SJC lab"
      circuit_id                      = var.express_route_circuit_id
      weight                          = 10
    }
  ]
  # f5xc_azure_global_network_name        = [ volterra_virtual_network.gn.name ]
  f5xc_azure_express_route_sku_standard  = true
  f5xc_azure_default_blocked_services    = false
  f5xc_azure_default_ce_sw_version       = true
  f5xc_azure_default_ce_os_version       = true
  f5xc_azure_no_worker_nodes             = true
  f5xc_azure_total_worker_nodes          = 0
  f5xc_azure_vnet_labels = {
    "site-mesh" = var.project_prefix,
    "deployment" = var.deployment
  }
  ssh_public_key                         = var.ssh_public_key
  custom_tags                            = local.custom_tags
}

output "vnet1" {
  value = module.vnet1
}
