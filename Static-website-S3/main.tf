terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "s3" {
  bucket = "rawlin.endure.portfolio"
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.s3.bucket
  source = "./website/index.html"
  key    = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "css" {
  bucket = aws_s3_bucket.s3.bucket
  source = "./website/style.css"
  key    = "style.css"
  content_type = "text/css"
}

resource "aws_s3_bucket_public_access_block" "s3pab" {
  bucket                  = aws_s3_bucket.s3.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "s3bp" {
  bucket = aws_s3_bucket.s3.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.s3.id}/*"
      }
    ]
    }
  )
}

resource "aws_s3_bucket_website_configuration" "s3bwc" {
  bucket = aws_s3_bucket.s3.id

  index_document {
    suffix = "index.html"
  }
}

output "link" {
    value = aws_s3_bucket_website_configuration.s3bwc.website_endpoint
  
}

