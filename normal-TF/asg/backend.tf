terraform {
  backend "s3" {
    bucket = "state-file-study"
    key = "terraform-practice/normal-TF/asg/terrform.tfstate"
    use_lockfile = true
    encrypt = true
    region = "us-east-1"
  }
}