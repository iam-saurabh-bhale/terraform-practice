terraform {
  backend "s3" {
    bucket       = "state-file-study"
    key          = "terraform-practice/normal-TF/ec2/normal-ec2/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}