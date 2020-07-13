
resource "aws_instance" "bastion-instance" {
  ami           = var.instance-ami
  instance_type = "t3.nano"

  subnet_id = aws_subnet.public-subnet.id

  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  key_name = aws_key_pair.mykeypair.key_name

  tags = {
    Name = "xmcore.bastion"
    customer:id="DZ01"
    net.matrix.application="datagrid"
    net.matrix.commonname="compute.dapla.net"
    net.matrix.costcenter="DZ01-VCC01"
    net.matrix.customer="DZ01"
    net.matrix.duns="iso.org.duns.039271257"
    net.matrix.environment="production"
    net.matrix.oid="iso.org.dod.internet.42387"
    net.matrix.organization="Denzuko"
    net.matrix.orgunit="XM Core Team"
    net.matrix.owner="FC13F74B@matrix.net"
    net.matrix.region="us-east-1"
    net.matrix.role="cloud compute"
  }
  }
}

resource "aws_instance" "private-instance" {
  ami           = var.instance-ami
  instance_type = "t3.medium"

  subnet_id = aws_subnet.private-subnet.id

  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  key_name = aws_key_pair.mykeypair.key_name
  
  tags = {
    customer:id="DZ01"
    Name="xmcore.compute"
    net.matrix.application="datagrid"
    net.matrix.commonname="compute.dapla.net"
    net.matrix.costcenter="DZ01-VCC01"
    net.matrix.customer="DZ01"
    net.matrix.duns="iso.org.duns.039271257"
    net.matrix.environment="production"
    net.matrix.oid="iso.org.dod.internet.42387"
    net.matrix.organization="Denzuko"
    net.matrix.orgunit="XM Core Team"
    net.matrix.owner="FC13F74B@matrix.net"
    net.matrix.region="us-east-1"
    net.matrix.role="cloud compute"
  }
}

resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = file(var.key_path)
}
