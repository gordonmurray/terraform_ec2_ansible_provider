resource "aws_security_group" "webserver" {
  name        = "webserver"
  description = "webserver instance access"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.default_tag
  }
}

resource "aws_security_group_rule" "webserver_egress" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.self_ip_address}/32"]
  security_group_id = aws_security_group.webserver.id
  description       = "SSH egress"
}

resource "aws_security_group_rule" "all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver.id
  description       = "Allow all out"
}

resource "aws_security_group_rule" "webserver_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver.id
  description       = "Webserver HTTP ingress"
}

resource "aws_security_group_rule" "webserver_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver.id
  description       = "Webserver HTTP ingress"
}

resource "aws_security_group_rule" "webserver_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.self_ip_address}/32"]
  security_group_id = aws_security_group.webserver.id
  description       = "SSH ingress"
}
