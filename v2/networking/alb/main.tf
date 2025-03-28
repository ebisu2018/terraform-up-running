resource "aws_lb" "front-alb" {
  name = var.alb_name
  load_balancer_type = "application"
  subnets = data.aws_subnets.default.ids
  security_groups = [aws_security_group.alb-sg.id]
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.front-alb.arn
  port = local.http_port
  protocol = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: Page not found"
      status_code  = "404"
    }
  }
}


resource "aws_lb_target_group" "asg-tg" {
  name = "${var.alb_name}-tg"
  port = local.http_port
  protocol = "HTTP"
  vpc_id = data.aws_vpc.default.id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}


resource "aws_lb_listener_rule" "alb-rule" {
  listener_arn = aws_lb_listener.http.arn
  priority = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.asg-tg.arn
  }
}

resource "aws_security_group" "alb-sg" {
  name = "${var.alb_name}-alb-sg"
}


resource "aws_security_group_rule" "allow_http_inbound" {
  from_port         = local.any_port
  protocol          = local.any_protocol
  security_group_id = aws_security_group.alb-sg.id
  to_port           = local.any_port
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