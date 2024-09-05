resource "aws_db_subnet_group" "medusa_subnet_group" {
  name        = "medusa-subnet-group"
  description = "Medusa subnet group"
  subnet_ids  = [
    aws_subnet.subnet1.id,
    aws_subnet.subnet2.id,
  ]

  tags = {
    Name = "medusa-subnet-group"
  }
}

resource "aws_db_instance" "medusa_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "medusadb"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.ecs_security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.medusa_subnet_group.name

  tags = {
    Name = "medusa-db"
  }
}
