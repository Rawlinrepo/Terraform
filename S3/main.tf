terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.14.1"
    }
     random = {
      source = "hashicorp/random"
      version = "3.7.2"
    } 
  }
}

resource "random_id" "random" {
    byte_length = 4 
}

/*
output "random" {
  value = random_id.random.id
}*/

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "s3" {
  bucket = "rawlin.endure.bucket"
  #bucket = "rawlin.endure.${random_id.random.dec}"
}

resource "aws_s3_object" "bucket-data" {
  bucket = aws_s3_bucket.s3.bucket
  source = "./file.txt"
  key = "data/file.txt"
}