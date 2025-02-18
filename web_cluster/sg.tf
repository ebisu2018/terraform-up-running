resource "aws_security_group" "instance-sg" {
  name = "${var.cluster_name}-sg-v2"
}


resource "aws_security_group_rule" "asg_rule" {
  from_port         = local.any_port
  protocol          = local.tcp_protocol
  security_group_id = aws_security_group.instance-sg.id
  to_port           = local.any_port
  type              = "ingress"
}


resource "aws_security_group" "alb-sg" {
  name = "${var.cluster_name}-alb-sg"
#   ingress {
#     from_port = local.any_port
#     to_port = local.any_port
#     protocol = local.tcp_protocol
#     cidr_blocks = local.all_ips
#   }
#   egress {
#     from_port = local.any_port
#     to_port = local.any_port
#     protocol = local.any_protocol
#     cidr_blocks = local.all_ips
#   }
}


resource "aws_security_group_rule" "allow_http_inbound" {
  from_port         = local.http_port
  protocol          = local.tcp_protocol
  security_group_id = aws_security_group.alb-sg.id
  to_port           = local.http_port
  cidr_blocks = local.all_ips
  type              = "ingress"
}


resource "aws_security_group_rule" "allow_all_outbound" {
  from_port         = local.any_port
  protocol          = local.any_protocol
  security_group_id = aws_security_group.alb-sg.id
  to_port           = local.any_port
  type              = "egress"
  cidr_blocks = local.all_ips
}
