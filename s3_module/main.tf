provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = "t2.micro" # Updated to a valid instance type
}

resource "aws_s3_bucket" "example" {
  bucket = "my-bucket"
  acl    = "private" # Changed ACL to private for enhanced security
}

resource "aws_s3_bucket_policy" "example_policy" {
  bucket = aws_s3_bucket.example.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Deny"
        Action   = "s3:*"
        Resource = "${aws_s3_bucket.example.arn}/*"
        Principal = {
          AWS = "*"
        }
        Condition = {
          Bool = {
            "aws:SecureTransport" : "false"
          }
        }
      }
    ]
  })
}
