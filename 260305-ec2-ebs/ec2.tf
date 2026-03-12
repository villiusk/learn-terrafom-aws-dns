resource "aws_instance" "server2" {
  ami           = var.ami_image
  instance_type = "t3.micro"
  key_name      = "lum-laptop"

  tags = {
    Name = "server2"
  }
}

