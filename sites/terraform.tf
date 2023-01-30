terraform {
  cloud {
    organization = "f5xc-uc01"

    workspaces {
      name = "sites"
    }
  }
}
