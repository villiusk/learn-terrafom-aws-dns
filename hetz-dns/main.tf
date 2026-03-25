variable "dns_records" {
  type = map(object({
    value = string
    ttl   = number
  }))
}

provider "hcloud" {}

data "hcloud_zone" "zone" {
  name = "n0d.site"
}

resource "hcloud_zone_rrset" "a_records" {
  for_each = var.dns_records

  zone = data.hcloud_zone.zone.name
  name = each.key
  type = "A"
  ttl  = each.value.ttl

  records = [
    {
      value = each.value.value
    }
  ]
}
