
# Provision the RDS database instance
resource "aws_db_instance" "main" {
  multi_az = true
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_type
  identifier           = "${var.db_name}-instance"
  username             = var.db_username
  password             = var.db_password
  db_name              = var.db_name
  allocated_storage    = 20
  storage_type         = "gp2"
  max_allocated_storage = 100
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  backup_retention_period = 7 # Retain backups for 7 days
  deletion_protection     = true # Prevents accidental deletion
  performance_insights_enabled = true
  skip_final_snapshot = false
  parameter_group_name = "default.${var.db_engine}${var.db_engine_version}"
}
