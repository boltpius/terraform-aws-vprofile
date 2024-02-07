module vpc {
  source  = "terraform-aws-modules/vpc/aws//examples/complete"
 # version = "version"
  name = var.vpc_name
  cidr = var.vpc_cidr

  azs = [var.avaiablity_zone1, var.avaiablity_zone2, var.avaiablity_zone3]
  private_subnets = [var.priv1_cidr, var.priv2_cidr, var.priv3_cidr]
  public_subnets = [var.pub1_cidr, var.pub2_cidr, var.pub3_cidr]

  enable_nat_gatway = true
  single-nat_gateway = true
  enable_dns_hostnames = true 
  enable_dns_support = true 
  tags = {
    Terraform = "true"
    Environment = "Prod"
  }
}
