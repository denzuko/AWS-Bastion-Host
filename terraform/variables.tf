variable "default-tags" {
    type    = map
    default = {
        application    = "datagrid"
        role           = "cloud compute"
        costcenter     = "DZ01-VCC01"
        customer       = "DZ01"
        duns           = "iso.org.duns.039271257"
        oid            = "iso.org.dod.internet.42387"
        environment    = "production"
        organization   = "denzuko"
        orgunit        = "XM Core Team"
        owner          = "FC13F74B@matrix.net"
        region         = "us-east-1"
    }
}

variable public_key {
    default="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCWYSVqzAgCHK35HPnaIfhS9zDQxGuSfr6SsB1+YaLeDgdIJ58YFrdhrIJEnNK8xvEdMOTXnIddmKjEQJBhd4J+aMS9JbfJ+9rJ9Nq4CXEwWogpOynPYes+YKcikjwqkYPtWU3cc3HeNieOT6VLyNyuxJBy8GLzXbeJ+Qm6hnvYSiYG+2LeRlVwgwkWR0YAORRWksSTYc8CJ94d1kLYJfKNFCFmMx+Qtui6kh3BwYzpc8CnASx1cWAr3j7z+Dgzzy0x7iAxlIiuooX5fSuU9LWRNqXaW/cMgtPCEMIMbRKie7Ptdjc3iUKpZkrxEbHWHgf7lBGm1YgmVHgiLVZQX/nj"

variable profile {
    default="personal"
}

variable instance-ami {
    default="ami-0964eb2dc8b836eb6"
}

variable key_path {
    default = "keys/mykeypair.pub"
}

variable "image_id" {
  type    = map
  default = {
    "eu-west-1" = "ami-049f322a544cfcf88"
    "us-east-1" = "ami-04e7b4117bb0488e4"
    "us-west-1" = "ami-01456a894f71116f2"
  }
}

variable "sizes" {
    type    = map
    default = {
        "bastion-instance" = "t3.nano"
        "private-instance" = "t3.medium"
    }
}

variable "max_size" {
    default = 1
}

variable "min_size" {
    default = 0
}

variable "cidr" {
    type    = map
    default = {
        "network"   = "10.0.0.0/27"
        "private"   = "10.0.0.16/28"
        "public"    = "10.0.0.0/28"
        "anycast"   = "0.0.0.0/0"
    }
}
