terraform {
  backend "s3" {
    bucket = "sp8-terraform"
    key    = "tools/terraform.tfstate"
    region = "us-east-1"
  }
}