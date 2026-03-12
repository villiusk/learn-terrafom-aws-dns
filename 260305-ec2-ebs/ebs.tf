resource "aws_ebs_volume" "ebs-volume1" {
  availability_zone = aws_instance.server2.availability_zone
  size              = 12
  encrypted         = false


  lifecycle {
    prevent_destroy = true
  }


  tags = {
    Name        = "ebs-demo"
    CreatedBy   = "VKA"
    DateCreated = "20260305"
    Env         = "PoC"
  }
}

resource "aws_volume_attachment" "mount-ebsvolume" {
  depends_on = [aws_instance.server2]

  device_name = "/dev/xvdd"
  instance_id = aws_instance.server2.id
  volume_id   = aws_ebs_volume.ebs-volume1.id
}
