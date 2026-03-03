provider "aws" {
  region = "eu-north-1"
}

provider "hcloud" {}

resource "aws_instance" "server1" {
   ami            = "ami-0e63a5a9c1c7e5563"
   instance_type  = "t3.micro"
   key_name       = "lum-laptop"

   tags = {
     Name= "Server1-test"
   }
}

output "server1_public_ip" {
  value = aws_instance.server1.public_ip
}


data "hcloud_zone" "zone1" {
  name="n0d.site"
}

resource "hcloud_zone_rrset" "server1" {
  depends_on =[aws_instance.server1]
  zone = "n0d.site"
  name = "serveris1" 
  type = "A"
  ttl = 60

  records=[{ value=aws_instance.server1.public_ip }]
}

resource "hcloud_zone_rrset" "wildcard_server1" {
  depends_on =[aws_instance.server1]
  zone = "n0d.site"
  name = "*.serveris1"
  type = "A"
  ttl = 60

  records=[{ value=aws_instance.server1.public_ip }]
}
