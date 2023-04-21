module "wl-us-west-2" {
  source            = "./aws"
  for_each          = {for subnet in local.tgw_spoke_subnets.subnets:  subnet.subnet_name => subnet if "us-west-2" == substr(subnet.availability_zone,0,9)}
  appdir            = "main-app"
  app               = "mainapp"
  traffic           = true
  fqdn              = var.fqdn
  deployment        = var.deployment
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
  appdir            = "back-end"
  app               = "backend"
  deployment        = var.deployment
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
  appdir            = "app2"
  app               = "app2"
  azure_zone                                 = "1"
  azure_zones                                = ["1"]
  azure_region                               = "westus2"
  site_name         = each.value.subnet_name
  azure_resource_group_name                  = each.value.resource_group
  azure_virtual_machine_size                 = "Standard_DS1_v2"
  azure_virtual_machine_name                 = format("%s-arcadia-app2", each.value.subnet_name)
  azure_linux_virtual_machine_admin_username = "ubuntu"
  ssh_public_key                             = var.ssh_public_key
  custom_tags                                =  {
    Name    = format("%s-arcadia-app2", each.value.subnet_name)
    Creator = var.owner_tag
    deployment = var.deployment
  }

  azure_network_interfaces = [
    {
      name             = format("%s-arcadia-app2-if",each.value.subnet_name)
      tags             = { "tagA" : "tagValueA" }
      ip_configuration = {
        subnet_id                     = each.value.subnet_id
        create_public_ip_address      = true
        private_ip_address_allocation = "Dynamic"
      }
    }
  ]
}

module "wl-vsphere1" {
  source             = "./vsphere"
  for_each           = {for network in local.vsphere_networks.network: network.network_id => network}
  appdir             = "app3"
  app                = "app3"
  name               = format("%s-wl-vshpere1", var.project_prefix)
  fcos_vm_template    = var.fcos_vm_template
  guest_type         = var.guest_type
  vsphere_user       = var.vsphere_user
  vsphere_password   = var.vsphere_password
  vsphere_server     = var.vsphere_server
  vsphere_datacenter = var.vsphere_datacenter
  vsphere_cluster    = var.vsphere_cluster
  vsphere_host       = "10.200.0.100"
  vsphere_datastore  = var.vsphere_datastore
  network_id         = each.value.network_id
  ssh_public_key     = var.ssh_public_key
  cpus               = 1
  memory             = 2048
}

output "instances" {
  value = [ module.wl-us-east-1, module.wl-us-west-2, module.wl-westus2, module.wl-vsphere1 ]
}
