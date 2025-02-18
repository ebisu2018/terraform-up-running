resource "aws_launch_template" "instance-tpl" {
  image_id = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.instance-sg.id]

  user_data = data.template_file.user-data.rendered
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "asg-demo" {
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired
  target_group_arns = [aws_lb_target_group.asg-tg.arn]
  health_check_type = "ELB"

  vpc_zone_identifier = data.aws_subnets.default.ids
  launch_template {
    id = aws_launch_template.instance-tpl.id
  }
}
