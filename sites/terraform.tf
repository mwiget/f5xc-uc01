terraform {
  cloud {
    organization = "f5xc-vela"

    workspaces {
      name = "sites"
    }
  }
}
