module "resource_group" {
  source                         = "../modules/azure/resource_group"
  azure_region                   = var.azure_region
  azure_resource_group_name      = format("%s-rg", var.vnet_name)
}

module "vnet" {
  source                         = "../modules/azure/virtual_network"
  azure_vnet_name                = var.vnet_name
  azure_vnet_primary_ipv4        = var.vnet_cidr_block
  azure_vnet_resource_group_name = module.resource_group.resource_group["name"]
  azure_region                   = module.resource_group.resource_group["location"]
}

module "azure_subnet" {
  source                           = "../modules/azure/subnet"
  azure_vnet_name                  = module.vnet.vnet["name"]
  azure_subnet_name                = format("%s-subnet", var.vnet_name)
  azure_subnet_address_prefixes    = [var.vnet_subnet_cidr_block]
  azure_subnet_resource_group_name = module.resource_group.resource_group["name"]
}

