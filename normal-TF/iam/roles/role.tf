resource "aws_iam_role" "s3_admin_role" {
  name = "S3AdminRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          AWS = "arn:aws:iam::652053589787:user/saurabh"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "assume_s3_admin_role" {
  name        = "AssumeS3AdminRole"
  description = "Allows Saurabh to assume the S3AdminRole"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"

        Resource = aws_iam_role.s3_admin_role.arn
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "saurabh_assume_role" {
  user       = "Saurabh"
  policy_arn = aws_iam_policy.assume_s3_admin_role.arn
}

resource "aws_iam_role_policy_attachment" "s3_admin_policy" {
  role = aws_iam_role.s3_admin_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}