output "alb_dns" {
  value = aws_lb.demo-lb.dns_name
}

output "asg_name" {
  value = aws_autoscaling_group.asg-demo.name
}

output "alb_security_group_id" {
  value = aws_security_group.alb-sg.id
}
