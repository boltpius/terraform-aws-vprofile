variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "ami" {
  type = map(any)
  default = {
    eu-west-1 = "ami-08031206a0ff5a6ac"
    eu-west-2 = "ami-0e5f882be1900e43b"
  }
}

variable "priv_key_path" {
  type    = string
  default = "piuskeys"
}

variable "pub_key_path" {
  type    = string
  default = "piuskeys.pub"
}

variable "myip" {
  type    = string
  default = "151.228.88.44/32"
}

variable "user" {
  type    = string
  default = "ubuntu"
}

variable "rmquser" {
  type    = string # this will be used for creating elastic cache 
  default = "rabbit"
}

variable "rmqpass" {
  type    = string
  default = "Rabbit12345@"
}

variable "dbuser" {
  type    = string # this will be used for creating  RDS
  default = "admin"
}

variable "dbpass" {
  type    = string
  default = "admin12345"
}

variable "dbname" {
  type    = string
  default = "accounts"
}

variable "instance_count" {
  type    = string
  default = "1"
}

variable "vpc_name" {
  type    = string
  default = "vprofile-vpc2"
}

variable "avaiablity_zone1" {
  type    = string
  default = "eu-west-1a"
}


variable "avaiablity_zone2" {
  type    = string
  default = "eu-west-1b"
}


variable "avaiablity_zone3" {
  type    = string
  default = "eu-west-1c"
}
#

variable "vpc_cidr" {
  type    = string
  default = "172.21.0.0/16"
}

variable "pub1_cidr" {
  type    = string
  default = "172.21.1.0/24"
}

variable "pub2_cidr" {
  type    = string
  default = "172.21.2.0/24"
}

variable "pub3_cidr" {
  type    = string
  default = "172.21.3.0/24"
}

variable "priv1_cidr" {
  type    = string
  default = "172.21.4.0/24"
}

variable "priv2_cidr" {
  type    = string
  default = "172.21.5.0/24"
}

variable "priv3_cidr" {
  type    = string
  default = "172.21.6.0/24"
}




