resource "aws_s3_bucket" "sample-bucket" {
    bucket = "sample-bucket-bhale"
    tags = {
      Name = "sample-bucket"
      Env = "Study"
    }
}

resource "aws_s3_bucket_public_access_block" "sample-bucket-access" {
    bucket = aws_s3_bucket.sample-bucket.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "sample-bucket-versioning" {
    bucket = aws_s3_bucket.sample-bucket.id
    versioning_configuration {
      status = "Enabled"
    }
}
