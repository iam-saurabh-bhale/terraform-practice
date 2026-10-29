terraform {
  backend "s3" {
    bucket = "state-file-study"
    key = "terraform-practice/normal-TF/rds/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true
  }
}