module "hub_vnet_a" {
  source                  = "./azure"
  azure_region            = "eastus2"
  azure_az                = "1"
  vnet_name               = "${var.project_prefix}-hub-vnet-a"
  vnet_cidr_block         = "10.101.5.0/24"
  vnet_subnet_cidr_block  = "10.101.5.0/26"
  custom_tags             = {
    Name  = "${var.project_prefix}-hub-vnet-a"
    Owner = var.owner_tag
  }
  ssh_public_key          = var.ssh_public_key
}

module "hub_vnet_b" {
  source                  = "./azure"
  azure_region            = "eastus2"
  azure_az                = "2"
  vnet_name               = "${var.project_prefix}-hub-vnet-b"
  vnet_cidr_block         = "10.101.6.0/24"
  vnet_subnet_cidr_block  = "10.101.6.0/26"
  custom_tags             = {
    Name  = "${var.project_prefix}-hub-vnet-b"
    Owner = var.owner_tag
  }
  ssh_public_key          = var.ssh_public_key
}

output "hub_vnet_a" {
  value = module.hub_vnet_a
}
output "hub_vnet_b" {
  value = module.hub_vnet_b
}
