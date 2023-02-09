output "resource_group" {
  value = module.resource_group
}

output "vnet" {
  value = module.vnet.vnet
}

output "subnet" {
  value = module.azure_subnet
}

output "security_group_sa" {
  value = azurerm_subnet_network_security_group_association.xc
}
