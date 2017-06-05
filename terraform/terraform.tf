terraform {
  backend "s3" {
    bucket = "speee-security-bootcamp-infra"
    key = "terraform"
  }
}

resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = "speee-security-bootcamp-infra"
  acl = "private"
  force_destroy = true
}
