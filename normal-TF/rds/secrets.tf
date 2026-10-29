# Find the existing secret
data "aws_secretsmanager_secret" "rds" {
  name = "prod/rds/mysql"
}

# Retrieve the current secret version
data "aws_secretsmanager_secret_version" "rds" {
  secret_id = data.aws_secretsmanager_secret.rds.id
}

# Decode the JSON secret
locals {
  rds_credentials = jsondecode(
    data.aws_secretsmanager_secret_version.rds.secret_string
  )
}