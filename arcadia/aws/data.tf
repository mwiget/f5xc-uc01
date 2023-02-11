data "ct_config" "workload" {
  content = templatefile("./templates/fcos_arcadia.yaml", { 
    appdir = var.appdir,
    app = var.app,
    traffic = var.traffic,
    fqdn = var.fqdn,
    ssh_public_key = var.ssh_public_key
  })
  strict = true
}

data "aws_ami" "latest-fcos" {
most_recent = true
owners = ["125523088429"] # Fedora CoreOS Owner

  filter {
      name   = "name"
      values = ["fedora-coreos-*"]
  }
  filter {
      name   = "architecture"
      values = ["x86_64"]
  }
  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}
