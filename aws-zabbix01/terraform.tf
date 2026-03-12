terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      #version = "~> 1.50"
    }

    aws = {
      source  = "hashicorp/aws"
      #version = "~> 5.92"
    }
  }

  backend "s3" {
    bucket                      = "tfstate"
    key                         = "aws-zabbix01/terraform.tfstate"
    region                      = "garage"
    endpoints                   = { s3 = "http://garage.n0d.site:3900" }
    use_path_style              = true
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true

    profile = "garage" # backend always uses MinIO creds
  }
}

