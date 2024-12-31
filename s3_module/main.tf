# Add required Terraform version
terraform {
  required_version = ">= 1.0.0" # TFLint: Required version constraint
}

# Add required providers with version constraints
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0" # TFLint: Missing version constraint for provider
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

# AWS Instance with encrypted block device and IMDSv2 enabled
resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = "t2.micro"

  # Enable encrypted block device
  root_block_device {
    encrypted  = true                                                 # TFSec: Ensure instance has encrypted block device
    kms_key_id = "arn:aws:kms:us-west-1:123456789012:key/your-key-id" # Replace with your AWS KMS key ID
  }

  # Enable IMDSv2
  metadata_options {
    http_tokens = "required" # TFSec: Activate session tokens for IMDS
  }
}

# S3 bucket with public access blocked
resource "aws_s3_bucket" "example" {
  bucket = "my-secure-bucket"
  acl    = "private" # TFSec: Ensure bucket ACL is private
}

# Block public access for S3 bucket
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true # TFSec: Block public ACL
  block_public_policy     = true # TFSec: Block public policies
  ignore_public_acls      = true
  restrict_public_buckets = true
}
