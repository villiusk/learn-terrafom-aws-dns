terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.50"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  #required_version = ">= 1.2"
}
