resource "aws_db_subnet_group" "vprofile-rds-subgrp" {
  name       = "rds-subnet-group"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "Subnet Group for RDS"
  }
}

resource "aws_elasticache_subnet_group" "vprofile-ecache-subgrp" {
  name       = "ecache-subnet-group"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "Subnet Group for elastic-cache"
  }
}

resource "aws_db_instance" "vprofile_rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t2.micro"
  db_name                = var.dbname
  username               = var.dbuser
  password               = var.dbpass
  parameter_group_name   = "default.mysql8.0"
  multi_az               = "false"
  publicly_accessible    = "false"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.vprofile-rds-subgrp.name
  vpc_security_group_ids = [aws_security_group.vprofile_backend_sg.id]
}

resource "aws_elasticache_cluster" "vprofile_cache" {
  cluster_id           = "vprofile-cache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [aws_security_group.vprofile_backend_sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.vprofile-ecache-subgrp.name
}

resource "aws_mq_broker" "vprofile_rmq" {
  broker_name        = "vprofile_rmq"
  engine_type        = "RabbitMQ"
  engine_version     = "3.11.20"
  host_instance_type = "mq.t3.micro"

 # deployment_mode          = "ACTIVE_STANDBY_MULTI_AZ"  # Set the deployment mode to ACTIVE_STANDBY_MULTI_AZ
  publicly_accessible      = false  # Set to true if you want the broker to be publicly accessible

  security_groups    = [aws_security_group.vprofile_backend_sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]

  user {
    username = var.rmquser
    password = var.rmqpass
  }
}