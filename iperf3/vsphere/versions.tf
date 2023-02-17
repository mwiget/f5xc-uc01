terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.3.1"
    }
    ct = {
      source = "poseidon/ct"
      version = ">= 0.11.0"
    }
  }
}
