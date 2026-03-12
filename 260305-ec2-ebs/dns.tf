data "hcloud_zone" "zone" {
  name = var.zone_name
}

resource "hcloud_zone_rrset" "server2" {
  depends_on = [aws_instance.server2]

  zone = var.zone_name
  name = "server2"
  type = "A"
  ttl  = 60

  records = [{
    value = aws_instance.server2.public_ip
  }]
}
