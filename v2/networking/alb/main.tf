resource "aws_lb" "front-alb" {
  name = var.alb_name
  load_balancer_type = "application"
  subnets = var.subnet_ids
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

resource "aws_security_group" "alb-sg" {
  name = "${var.alb_name}-alb-sg"
}