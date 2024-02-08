resource "aws_security_group" "vprofile_lb_sg"{
    name = "vprofile_lb_sg"
    vpc_id = module.vpc.vpc_id
    egress {
        from_port = 0
        protocol = "-1"
        to_port = 0 
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = 80
        protocol = "tcp"
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]

    }
}

resource "aws_security_group" "vprofile_bastion_sg" {

    name = "vprofile-bastion-sg"
    vpc_id = module.vpc.vpc_id

    egress {
        from_port = 0
        protocol = "-1"
        to_port = 0 
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        protocol = "tcp"
        to_port = 22
        cidr_blocks = [var.myip]

    }


}

resource "aws_security_group" "vprofile_prod_sg"{
    name = "vprofile-prod-sg"
    vpc_id = module.vpc.vpc_id
    egress {
        from_port = 0
        protocol = "-1"
        to_port = 0 
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = 22
        protocol = "tcp"
        to_port = 22
        security_groups = [aws_security_group.vprofile_bastion_sg.id]

    }
}


resource "aws_security_group" "vprofile_backend_sg"{
    name = "vprofile-backend-sg"
    vpc_id = module.vpc.vpc_id
    egress {
        from_port = 0
        protocol = "-1"
        to_port = 0 
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = 0
        protocol = "-1"
        to_port = 0
        security_groups = [aws_security_group.vprofile_prod_sg.id]

    }
}

resource "aws_security_group_rule" "sec_group_allow_itself" {
    type = "ingress"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    security_group_id = aws_security_group.vprofile_backend_sg.id
    source_security_group_id = aws_security_group.vprofile_backend_sg.id
}
