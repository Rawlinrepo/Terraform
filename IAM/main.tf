terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.14.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

locals {
  users_data = yamldecode(file("./users.yml")).users
}

output "user-data" {
  value = local.users_data
}

#Create Users
resource "aws_iam_user" "users" {
  for_each = toset(local.users_data[*].username )
  name = each.value
}

resource "aws_iam_user_login_profile" "profile" {
  for_each = aws_iam_user.users
  user = each.value.name
  password_length = 10
  
  lifecycle {
    ignore_changes = [ 
      password_length,
      password_reset_required,
      pgp_key,
     ]
  }
}
