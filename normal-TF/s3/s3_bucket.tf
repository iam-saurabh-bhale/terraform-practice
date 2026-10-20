resource "aws_s3_bucket" "sample-bucket" {
    bucket = "sample-bucket-bhale"
    tags = {
      Name = "sample-bucket"
      Env = "Study"
    }
}