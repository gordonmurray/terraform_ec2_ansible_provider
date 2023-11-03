data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-*arm64*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "webserver" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t4g.small"
  key_name                = aws_key_pair.key.key_name
  subnet_id               = var.subnet
  vpc_security_group_ids  = [aws_security_group.webserver.id]
  disable_api_termination = true
  count                   = 3

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = "10"

    tags = {
      Name = var.default_tag
    }
  }

  tags = {
    Name = var.default_tag
  }

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

}
