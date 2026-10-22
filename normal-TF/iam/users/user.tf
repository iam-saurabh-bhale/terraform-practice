resource "aws_iam_user" "bhale" {
    name = "bhale"
}

resource "aws_iam_user_login_profile" "bhale-user" {
    user = aws_iam_user.bhale.name
    password_reset_required = true
}

output  "bhale-password" {
    value = aws_iam_user_login_profile.bhale-user.password
}