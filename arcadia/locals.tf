locals {
  tgw_spoke_subnets = jsondecode(file("../sites/subnets-tgw-spoke.json"))
  vnet_spoke_subnets = jsondecode(file("../sites/subnets-vnet-spoke.json"))
}
