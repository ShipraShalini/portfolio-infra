terraform {
  backend "s3" {
    bucket         = "moonlace-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
