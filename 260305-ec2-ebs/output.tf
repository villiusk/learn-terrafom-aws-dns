output "server2_public_ip" {
  value = aws_instance.server2.public_ip
}

output "server2_private_ip" {
  value = aws_instance.server2.private_ip
}

