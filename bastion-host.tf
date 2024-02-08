resource "aws_instance" "vprofile-jump-server" {
  ami                         = var.ami[var.region]
  instance_type               = "t2.micro"
  key_name                    = var.priv_key_path
  vpc_security_group_ids      = [aws_security_group.vprofile_bastion_sg.id]
  subnet_id                   = module.vpc.public_subnets[count.index] # joins converts lists to strings
  count                       = var.instance_count
  associate_public_ip_address = true
  tags = {
    Name = "bastion-host-infra"
  }

  provisioner "file" {
    content     = templatefile("templates/db-deploy.tmpl", { rds-endpoint = aws_db_instance.vprofile_rds.address, dbuser = var.dbuser, dbpass = var.dbpass, dbname = var.dbname }) # use address the get the value of the resource endpoint
    destination = "/tmp/vprofile-dbinitialize.sh"
  }


  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vprofile-dbinitialize.sh",
      "sudo  /tmp/vprofile-dbinitialize.sh"
    ]
  }

  connection {
    user        = var.user
    private_key = file("piuskeys")
    host        = self.public_ip
  }



  depends_on = [aws_db_instance.vprofile_rds]


}

output "publicIP" {
  value = aws_instance.vprofile-jump-server.*.public_ip # using wide card * to access all the ips created by this resource.
}