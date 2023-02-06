module "wl-us-west-2" {
  source            = "./instance"
  for_each          = {for subnet in local.subnets.subnets:  subnet.subnet_name => subnet if "us-west-2" == substr(subnet.availability_zone,0,9)}
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
  source            = "./instance"
  for_each          = {for subnet in local.subnets.subnets:  subnet.subnet_name => subnet if "us-east-1" == substr(subnet.availability_zone,0,9)}
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

output "instances" {
  value = [ module.wl-us-east-1, module.wl-us-west-2 ]
}
