resource "aws_security_group" "allow-ssh" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  tags = "${merge(map('Name', 'allow-anycast-ssh'), var.default_tags)}"
}

resource "aws_security_group" "allow-web" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-anycast-web"
  description = "security group that allows https, http ingress traffic"
  tags = "${merge(map('Name', 'allow-anycast-web'), var.default_tags)}"
}

resource "aws_security_group" "allow-zerotier" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-anycast-web"
  description = "security group that allows zerotier traffic"
  tags = "${merge(map('Name', 'allow-anycast-web'), var.default_tags)}"
}

resource "aws_security_group" "allow-swarm" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-private-swarm"
  description = "Allows swarm mode on private network"
  tags        = "${merge(map(
    'Name', 'allow-private-swarm'),
    var.default_tags)}"
}

resource "aws_security_group_rule" "egress_any" {
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["${var.cidr.anycast}"]
  security_group_id = "${aws_security_group.allow-ssh.id}"
  tags = "${merge(map('Name', 'egress_any'), var.default_tags)}"
}

resource "aws_security_group_rule" "ingress_zerotier" {
  type        = "ingress"
  from_port   = 9993
  to_port     = 9993
  protocol    = "udp"
  cidr_blocks = ["${var.cidr.anycast}"]
  security_group_id = "${aws_security_group.allow-zerotier.id}"
  tags = "${merge(map('Name', 'ingress_zerotier'), var.default_tags)}"
}

resource "aws_security_group_rule" "ingress_client_swarm" {
  type              = "ingress"
  from_port         = 2376
  to_port           = 2376
  protocol          = "tcp"
  cidr_blocks       = ["${var.cidr.private}"]
  security_group_id = "${aws_security_group.alllow-swarm.id}"
  tags              = "${merge(map('Name', "ingress_master_swarm"), var.default_tags)}"
}

resource "aws_security_group_rule" "ingress_master_swarm" {
  type              = "ingress"
  from_port         = 2377
  to_port           = 2377
  protocol          = "tcp"
  cidr_blocks       = ["${var.cidr.private}"]
  security_group_id = "${aws_security_group.alllow-swarm.id}"
  tags              = "${merge(map('Name', "ingress_master_swarm"), var.default_tags)}"
}

resource "aws_security_group_rule" "ingress_nds_tcp_swarm" {
  type              = "ingress"
  from_port         = 7946
  to_port           = 7946
  protocol          = "tcp"
  cidr_blocks       = ["${var.cidr['private']}"]
  security_group_id = "${aws_security_group.alllow-swarm.id}"
  tags              = "${merge(map('Name', "ingress_nds_tcp_swarm"), var.default_tags)}"
}

resource "aws_security_group_rule" "ingress_nds_udp_swarm" {
  type              = "ingress"
  from_port         = 7946
  to_port           = 7946
  protocol          = "udp"
  cidr_blocks       = ["${var.cidr['private']}"]
  security_group_id = "${aws_security_group.alllow-swarm.id}"
  tags              = "${merge(map('Name', "ingress_nds_udp_swarm"), var.default_tags)}"
}

resource "aws_security_group_rule" "ingress_network_swarm" {
  type              = "ingress"
  from_port         = 4789
  to_port           = 4789
  protocol          = "udp"
  cidr_blocks       = ["${var.cidr.private}"]
  security_group_id = "${aws_security_group.alllow-swarm.id}"
  tags              = "${merge(map('Name', "ingress_network_swarm"), var.default_tags)}"
}

resource "aws_security_group_rule" "ingress_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["${var.cidr.anycast}"]
  security_group_id = "${aws_security_group.allow-ssh.id}"
  tags = "${merge(map('Name', 'ingress_ssh'), var.default_tags)}"
}

resource "aws_security_group_rule" "ingress_https" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["${var.cidr.anycast}"]
  security_group_id = "${aws_security_group.allow-web.id}"
  tags = "${merge(map('Name', 'ingress_http'), var.default_tags)}"
}

resource "aws_security_group_rule" "ingress_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["${var.cidr.anycast}"]

  security_group_id = "${aws_security_group.allow-web.id}"
  tags = "${merge(map('Name', 'ingress_https'), var.default_tags)}"
}
