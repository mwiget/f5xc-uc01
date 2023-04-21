terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.34.0"
    }
    volterra = {
      source  = "volterraedge/volterra"
      version = ">= 0.11.18"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.17.0"
    }

    ct = {
      source  = "poseidon/ct"
      version = ">= 0.11.0"
    }

    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.3.1"
    }

    local = ">= 2.2.3"
    null  = ">= 3.1.1"
  }
}
