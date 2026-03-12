#TF_VAR_zone_name = "n0d.site"
#TF_VAR_aws_region = "eu-north-1"

# debian13 image
#TF_VAR_ami_image = "ami-0e63a5a9c1c7e5563"

variable "zone_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "ami_image" {
  type = string
}
