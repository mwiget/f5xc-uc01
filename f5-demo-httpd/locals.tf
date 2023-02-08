locals {
  subnets = jsondecode(file("../sites/subnets-spoke.json"))
  hub_subnets = jsondecode(file("../sites/subnets-hub.json"))
}
