resource "aws_iam_group" "developer-group" {
    name = "engineer-group"
}

resource "aws_iam_group_membership" "membership" {
    name = "engineer-group"
    users = [ "bhale" ]
    group = aws_iam_group.developer-group.name
}


data "aws_iam_policy" "s3-read-access" {
    name = "S3ReadOnlyAllBuckets"
}

resource "aws_iam_group_policy_attachment" "s3-read-only" {
    policy_arn = data.aws_iam_policy.s3-read-access.arn
    group = aws_iam_group.developer-group.name
  
}