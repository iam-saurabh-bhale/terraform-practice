terraform {
  backend "s3" {
    bucket = "state-file-study"
    key = "terraform-practice/normal-TF/s3/terraform.tfstate"
    encrypt = true
    use_lockfile = true
    region = "us-east-1"
  }
}