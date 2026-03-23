terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.50"
    }
  }

  backend "s3" {
    bucket                      = "tfstate"
    key                         = "hetzner-dns/terraform.tfstate"
    region                      = "eu-north-1"
    endpoints                   = { s3 = "http://minio.n0d.site:9000" }
    use_path_style              = true
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true

    use_lockfile = true

    profile = "minio" # backend always uses MinIO creds
  }
}
