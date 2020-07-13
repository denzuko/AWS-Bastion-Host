## SSH KEY

resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = file(var.key_path)
  tags = var.default-tags
}

## Environment

resource "aws_placement_group" "production" {
  name      = "production"
  strategy  = "cluster"
}

resource "aws_placement_group" "preproduction" {
  name      = "preproduction"
  strategy  = "cluster"
}

## Template

resource "aws_launch_template" "bastion" {
  name_prefix   = "xmcore.bastion-"
  image_id      = var.image_id[var.default-tags.region]
  tags          = var.default-tags

  instance_type = var.sizes["bastion-instance"]
  
  instance_initiated_shutdown_behavior = "terminate"
  disable_api_termination = true

  vpc_security_group_ids = [
    aws_security_group.allow-ssh.id,
    aws_security_group.allow-zerotier.id,
  ]
  
  key_name = aws_key_pair.mykeypair.key_name
  
  network_interfaces {
    subnet_id = aws_subnet.public-subnet.id
  }

  tags  = var.default-tags  
}

resource "aws_launch_template" "compute" {
  name_prefix   = "xmcore.compute-"
  image_id      = var.image_id[var.default-tags.region]
  tags          = var.default-tags
  instance_type = var.sizes["private-instance"]
  
  instance_initiated_shutdown_behavior = "terminate"
  disable_api_termination = true

  vpc_security_group_ids = [
    aws_security_group.allow-ssh.id,
    aws_security_group.allow-web.id,
    aws_security_group.allow-zerotier.id,
  ]
  
  key_name = aws_key_pair.mykeypair.key_name
  
  network_interfaces {
    subnet_id = aws_subnet.private-subnet.id
  }
  
  tags  = var.default-tags
  
}

## Instance(s)

resource "aws_autoscaling_group" "bastion" {
  launch_template {
    id      = aws_launch_template.bastion.id
    version = "$Latest"
  } 
  vpc_zone_identifier  = [aws_subnet.public-subnet.id]
  desired_capacity     = 1
  min_size             = 1
  max_size             = 1
  placement_group      = aws_placement_group.production.id
}

resource "aws_autoscaling_group" "compute" {
  launch_template {
    id      = aws_launch_template.compute.id
    version = "$Latest"
  }  
  vpc_zone_identifier  = [aws_subnet.private-subnet.id]
  desired_capacity     = 1
  min_size             = var.min_size
  max_size             = var.max_size
  tags                 = var.default-tags
  placement_group      = aws_placement_group.production.id

}

