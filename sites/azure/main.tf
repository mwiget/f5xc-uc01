module "resource_group" {
  source                         = "../modules/azure/resource_group"
  azure_region                   = var.azure_region
  azure_resource_group_name      = format("%s-rg", var.vnet_name)
}

module "vnet" {
  source                         = "../modules/azure/virtual_network"
  azure_vnet_name                = var.vnet_name
  azure_vnet_primary_ipv4        = var.vnet_cidr_block
  azure_vnet_resource_group_name = module.resource_group.resource_group.name
  azure_region                   = module.resource_group.resource_group.location
}

module "azure_subnet" {
  source                           = "../modules/azure/subnet"
  azure_vnet_name                  = module.vnet.vnet.name
  azure_subnet_name                = format("%s-subnet", var.vnet_name)
  azure_subnet_address_prefixes    = [var.vnet_subnet_cidr_block]
  azure_subnet_resource_group_name = module.resource_group.resource_group.name
}

#resource "aws_route" "bastion" {
#  route_table_id = aws_vpc.vpc.main_route_table_id
#  destination_cidr_block = var.bastion_cidr
#  gateway_id = aws_internet_gateway.gateway.id
#}

resource "azurerm_network_security_group" "nsg" {
  name                = format("%s-nsg", var.vnet_name)
  resource_group_name = module.resource_group.resource_group.name
  location            = var.azure_region
}

resource "azurerm_network_security_rule" "nsg-rule1" {
  name                        = "allow_all"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefixes     = [ "0.0.0.0/0" ]
  destination_address_prefix  = "*"
  resource_group_name         = module.resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_subnet_network_security_group_association" "xc" {
  subnet_id                 = module.azure_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
