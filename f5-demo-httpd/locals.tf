locals {
  subnets = jsondecode(file("../sites/subnets-spoke.json"))
}
