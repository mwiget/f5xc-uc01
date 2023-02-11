resource "aws_instance" "instance" {
  ami                         = data.aws_ami.latest-fcos.id
  instance_type               = var.instance_type
  user_data                   = data.ct_config.workload.rendered
  user_data_replace_on_change = true
  vpc_security_group_ids      = [
    var.security_group_id,
  ]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  #root_block_device {
  #  volume_size = 40
  #}
  #
  tags = {
    Name    = format("%s-arcadia-%s", var.subnet_name, var.app)
    Creator = var.owner_tag
    deployment = var.deployment
  }
}

