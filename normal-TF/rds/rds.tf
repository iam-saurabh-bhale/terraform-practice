resource "aws_db_instance" "prod_db" {
  identifier     = "prod-mysql-db"
  engine         = "mysql"
  instance_class = "db.t3.micro"

  allocated_storage = 20

  username = local.rds_credentials["username"]
  password = local.rds_credentials["password"]

  skip_final_snapshot = true
}