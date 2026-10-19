terraform {
  backend "s3" {
    bucket       = "state-file-study"
    key          = "terraform-practice/normal-TF/ec2/ec2-with-subnet-and-ebs/terraform.tfstate"
    use_lockfile = true
    encrypt      = true
    region       = "us-east-1"
  }
}