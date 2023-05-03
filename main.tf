data "aws_ami" "ubuntu" {

most_recent = true
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}



resource "aws_instance" "web" {
  count = var.instance_count
  ami             = data.aws_ami.ubuntu.id

  instance_type   = var.instance_type
  security_groups = [aws_security_group.allow_tls.name]
    root_block_device {
    volume_size = var.instance_root_device_size
    volume_type = "gp2"
  }

  tags = {
    Name = "devon-${count.index}"
  }
}
