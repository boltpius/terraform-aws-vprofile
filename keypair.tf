resource "aws_key_pair" "ssh-key" {
  key_name   = var.priv_key_path
  public_key = file(var.pub_key_path)
}
