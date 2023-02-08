output "resource_group" {
  value = module.resource_group
}

output "vnet" {
  value = module.vnet.vnet
}

output "subnet" {
  value = module.azure_subnet
}

