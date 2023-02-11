locals {
  tgw_spoke_subnets = jsondecode(file("../sites/subnets-tgw-spoke.json"))
  vnet_spoke_subnets = jsondecode(file("../sites/subnets-vnet-spoke.json"))
  labels = {
    "ves.io/app_type" = format("%s-arcadia", var.project_prefix)
    "app"             = format("%s-arcadia", var.project_prefix)
  }
}
