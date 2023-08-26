data "aws_subnets" "selected" {
  filter {
    name   = "tag:Name"
    values = var.subnetgroup

  }
  depends_on = [aws_subnet.sub]
}


resource "aws_db_subnet_group" "hi" {
  name       = "main"
  subnet_ids = data.aws_subnets.selected.ids

  tags = {
    Name = "My DB subnet group"
  }
  depends_on = [aws_subnet.sub, data.aws_subnets.selected]
}

resource "aws_db_instance" "myinstancedb" {
  allocated_storage      = 20
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "bhavana"
  password               = "bhavana1234"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.hi.name
  identifier             = "thisismydb"
  vpc_security_group_ids = [aws_security_group.dbsec.id]

  depends_on = [aws_vpc.itsmyvpc, aws_security_group.dbsec, aws_db_subnet_group.hi]
}