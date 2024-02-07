terraform {
  backend "s3" {
    bucket = "demo4500"
    key    = "terraformbackend/backend-vprofile"
    region = "eu-west-1"
  }
}
