terraform {
    backend "s3" {
        bucket = "state-file-study"
        key = "terraform-practice/normal-TF/iam/users/terraform.tfstate"
        use_lockfile = true
        encrypt = true
        region = "us-east-1"
    }
}