module "wl-us-west-2" {
  source            = "./aws"
  for_each          = {for subnet in local.tgw_spoke_subnets.subnets:  subnet.subnet_name => subnet if "us-west-2" == substr(subnet.availability_zone,0,9)}
  availability_zone = each.value.availability_zone
  site_name         = each.value.subnet_name
  subnet_name       = each.value.subnet_name
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  security_group_id = each.value.security_group_id
  instance_type     = "t3.nano"
  ssh_public_key    = var.ssh_public_key
  owner_tag         = "m.wiget@f5.com"
  providers         = {
    aws             = aws.us-west-2
  }
}

module "wl-us-east-1" {
  source            = "./aws"
  for_each          = {for subnet in local.tgw_spoke_subnets.subnets:  subnet.subnet_name => subnet if "us-east-1" == substr(subnet.availability_zone,0,9)}
  availability_zone = each.value.availability_zone
  site_name         = each.value.subnet_name
  subnet_name       = each.value.subnet_name
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  security_group_id = each.value.security_group_id
  instance_type     = "t3.nano"
  ssh_public_key    = var.ssh_public_key
  owner_tag         = "m.wiget@f5.com"
  providers         = {
    aws             = aws.us-east-1
  }
}

module "wl-westus2" {
  source                                     = "./azure"
  for_each                   = {for subnet in local.vnet_spoke_subnets.subnets: subnet.subnet_name => subnet}
  azure_zone                                 = "1"
  azure_zones                                = ["1"]
  azure_region                               = "westus2"
  site_name         = each.value.subnet_name
  azure_resource_group_name                  = each.value.resource_group
  azure_virtual_machine_size                 = "Standard_DS1_v2"
  azure_virtual_machine_name                 = format("%s-wl", each.value.subnet_name)
  azure_linux_virtual_machine_admin_username = "ubuntu"
  ssh_public_key                             = var.ssh_public_key
  custom_tags                                =  {
    Name    = format("%s-wl", each.value.subnet_name)
    Creator = var.owner_tag
  }

  azure_network_interfaces = [
    {
      name             = format("%s-wl-if",each.value.subnet_name)
      tags             = { "tagA" : "tagValueA" }
      ip_configuration = {
        subnet_id                     = each.value.subnet_id
        create_public_ip_address      = true
        private_ip_address_allocation = "Dynamic"
      }
    }
  ]
}

output "instances" {
  value = [ module.wl-us-east-1, module.wl-us-west-2, module.wl-westus2 ]
}
