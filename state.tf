resource "aws_s3_bucket" "terraform_state" {
  bucket = "moonlace-terraform-state"

  lifecycle {
    prevent_destroy = true
  }
}


terraform {
  backend "s3" {
    bucket         = "moonlace-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
