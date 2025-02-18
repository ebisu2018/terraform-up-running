# output "public_ip" {
#   description = "The public IP address of the web server"
#   value = aws_instance.demo-server.public_ip
# }

output "alb_dns" {
  value = aws_lb.demo-lb.dns_name
}


# subnets = tolist([
#   "subnet-08058823c682911ca",
#   "subnet-0e0ae1ad2f51d73c5",
#   "subnet-07b4a128068f8edea",
# ])
output "subnets" {
  value = data.aws_subnets.default.ids
}

output "asg_name" {
  value = aws_autoscaling_group.asg-demo.name
}


output "alb_security_group_id" {
  value = aws_security_group.alb-sg.id
}
