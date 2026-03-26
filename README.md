# My learning path of terraform with AWS
## Hetzner-DNS
## Cloudflare DNS
## package direnv
## Store state in s3 like minio

## State files saved on remote
Authentication to minio is in .aws/credentials separate profile minio.
There main (default) AWS profile to create resources on AWS Cloud.
Addiotional profile garage was created to test garagehq for store state file.

~/.aws/credentials
```
[minio]
aws_access_key_id = MINIO_KEY
aws_secret_access_key = MINIO_SECRET

[aws-prod]
aws_access_key_id = AWS_KEY
aws_secret_access_key = AWS_SECRET
```

examples
```
terraform {
  backend "s3" {
    bucket = "tfstate"
    key    = "myproject/terraform.tfstate"
    region = "us-east-1"

    endpoints = { s3 = "https://minio.example.local:9000" }
    use_path_style              = true
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true

    # <-- THIS prevents conflict:
    profile = "minio"
    use_lockfile = true
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "aws-prod"
}

---

terraform {
  backend "s3" {
    # ...
    profile                = "minio"
    shared_credentials_files = ["/run/secrets/minio-creds"]
  }
}

provider "aws" {
  region                  = "eu-west-1"
  profile                 = "aws-prod"
  shared_credentials_files = ["/run/secrets/aws-creds"]
}
```

After change made to store state file in s3 execute this command to enable.
```
terraform init -reconfigure
```

## NOT tested state storage on consul
```
terraform {
  backend "consul" {
    address = "http://consul:8500"
    path    = "terraform/state"
    lock    = true
  }
}
```

## Search latest AMI 
For search AMI need to know ownerid and image search pattern.
My  sugeted way to find AMI in AWS  console and using second command findout ownerid and search pattern.

```
aws ec2 describe-images --image-ids ami-01ef747f983799d6f --query "Images[*].OwnerId" --output text
aws ec2 describe-images --image-ids ami-01ef747f983799d6f --region eu-north-1
```


```
data "aws_ami" "example" {
  most_recent = true
  #owners      = ["099720109477"] # Owner is Canonical
  owners = ["136693071363"] # Owner amazon debian

  filter {
    name   = "name"
    values = ["debian-13-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
```
