# Configure the Cloudflare provider using the required_providers stanza
terraform {
 required_providers {
   cloudflare = {
     source = "cloudflare/cloudflare"
     version = "~> 4.0"
   }
 }
}
provider "cloudflare" {
  #api_token = var.cloudflare_api_token
}

variable "zone_name" { # pvz.: "example.com"
  type = string
}


data "cloudflare_zone" "this" {
  name = var.zone_name
}

resource "cloudflare_record" "router1" {
  zone_id = data.cloudflare_zone.this.id
  name    = "router"
  type    = "A"
  content = "192.168.1.1"

  ttl     = 1
  proxied = false
}
