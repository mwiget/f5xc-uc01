module "spoke_vnet_a" {
  source                  = "./azure"
  azure_region            = "westus2"
  azure_az                = "1"
  vnet_name               = "${var.project_prefix}-spoke-vnet-a"
  vnet_cidr_block         = "10.10.4.0/24"
  vnet_subnet_cidr_block  = "10.10.4.0/26"
  custom_tags             = {
    Name  = "${var.project_prefix}-spoke-vnet-a"
    Owner = var.owner_tag
  }
  ssh_public_key          = var.ssh_public_key
}

module "spoke_vnet_b" {
  source                  = "./azure"
  azure_region            = "westus2"
  azure_az                = "2"
  vnet_name               = "${var.project_prefix}-spoke-vnet-b"
  vnet_cidr_block         = "10.10.5.0/24"
  vnet_subnet_cidr_block  = "10.10.5.0/26"
  custom_tags             = {
    Name  = "${var.project_prefix}-spoke-vnet-b"
    Owner = var.owner_tag
  }
  ssh_public_key          = var.ssh_public_key
}

output "spoke_vnet_a" {
  value = module.spoke_vnet_a
}
output "spoke_vnet_b" {
  value = module.spoke_vnet_b
}
