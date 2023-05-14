provider "aws" {
  region  = var.AWS_REGION
  alias   = "virginia"
  profile = "default"
}
