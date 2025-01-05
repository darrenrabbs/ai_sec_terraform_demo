provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = "" # Invalid instance type (edit)
}

resource "aws_s3_bucket" "example" {
  bucket = "my-bucket"
  acl    = "public-read" # Public access
}
