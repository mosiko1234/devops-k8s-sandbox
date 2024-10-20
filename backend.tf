terraform {
  backend "s3" {
    bucket         = var.s3_bucket
    key            = "terraform/${var.env_name}/terraform.tfstate"
    region         = var.region
    encrypt        = true
    dynamodb_table = var.dynamodb_table
  }
}
