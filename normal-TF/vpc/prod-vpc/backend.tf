terraform {
  backend "s3" {
    bucket = "study-state-file"
    key = "terraform-practice/normal-TF/vpc/prod-vpc/terraform.tfstate"
    use_lockfile = true
    encrypt = true
    region = "us-east-1"
  }
}