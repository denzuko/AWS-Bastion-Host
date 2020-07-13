
variable "cmdb" {
    type    = "map"
    
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

variable region {
    default=var.cmdb.region
}

variable profile {
    default="personal"
}

variable instance-ami {
    default="ami-0964eb2dc8b836eb6"
}

variable key_path {
    default = "keys/mykeypair.pub"
}

variable "images" {
  type    = "map"
  default = {
    "eu-west-1" = "ami-049f322a544cfcf88"
    "us-east-1" = "ami-04e7b4117bb0488e4"
    "us-west-1" = "ami-01456a894f71116f2"
  }
}

variable "sizes" {
    type    = "map"
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
    type    = "map"
    default = {
        "network"   = "10.0.0.0/27"
        "private"   = "10.0.0.16/28"
        "public"    = "10.0.0.0/28"
        "anycast"   = "0.0.0.0/0"
    }
}

variable "default-tags" {
    type    = "map"
    default = {

        net.matrix.application  = var.cmdb.application
        net.matrix.costcenter   = var.cmdb.costcenter
        net.matrix.customer     = var.cmdb.customer
        net.matrix.duns         = var.cmdb.duns
        net.matrix.environment  = var.cmdb.environment
        net.matrix.oid          = var.cmdb.oid
        net.matrix.organization = var.cmdb.organization
        net.matrix.orgunit      = var.cmdb.orgunit
        net.matrix.owner        = var.cmdb.owner
        net.matrix.region       = var.cmdb.region
        net.matrix.role         = var.cmdb.role
}
