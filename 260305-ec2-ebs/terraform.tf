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

  backend "s3" {
    bucket                      = "tfstate"
    key                         = "260305-ec2-ebs/terraform.tfstate"
    region                      = "eu-north-1"
    endpoints                   = { s3 = "http://minio.n0d.site:9000" }
    use_path_style              = true
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true

    profile = "minio" # backend always uses MinIO creds
  }
}

