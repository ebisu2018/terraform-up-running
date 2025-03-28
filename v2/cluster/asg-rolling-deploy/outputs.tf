output "asg_name" {
  value = aws_autoscaling_group.asg-group.name
}

output "instance_security_group_id" {
  value = aws_security_group.instance-sg.id
}