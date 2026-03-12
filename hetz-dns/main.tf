provider "hcloud" {}
#  token   = var.hcloud_token
#}

# Create an A record in the zone
#resource "hcloud_dns_record" "test2" {
#  zone_id = 89014
#  name    = "test2"
#  type    = "A"
#  value   = "192.168.1.11"
#  ttl     = 3600
#}


data "hcloud_zone" "zone" {
  name = "n0d.site"
}


resource "hcloud_zone_rrset" "kvm" {
  zone = "n0d.site"
  name = "kvm"
  type = "A"
  ttl  = 60

  records = [{ value = "192.168.1.4" }]
}

resource "hcloud_zone_rrset" "minio" {
  zone = "n0d.site"
  name = "minio"
  type = "A"
  ttl  = 60

  records = [{ value = "192.168.1.11" }]
}


resource "hcloud_zone_rrset" "garage" {
  zone = "n0d.site"
  name = "garage"
  type = "A"
  ttl  = 60

  records = [{ value = "192.168.1.11" }]
}

resource "hcloud_zone_rrset" "lock" {
  zone = "n0d.site"
  name = "lock"
  type = "A"
  ttl  = 60

  records = [{ value = "192.168.1.11" }]
}
