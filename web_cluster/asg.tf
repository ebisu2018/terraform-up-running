resource "aws_launch_template" "instance-tpl" {
  image_id = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.instance-sg.id]

  user_data = file(var.user_data_script)
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

resource "aws_autoscaling_schedule" "scale_out_during_busy_hours" {
  count = var.enable_autoscaling ? 1 : 0

  autoscaling_group_name = aws_autoscaling_group.asg-demo.name
  scheduled_action_name  = "${var.cluster_name}-scale-out-during-busy-hours"
  min_size = 2
  max_size = 10
  desired_capacity = 10
  recurrence = "0 9 * * *"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  count = var.enable_autoscaling ? 1 : 0

  autoscaling_group_name = aws_autoscaling_group.asg-demo.name
  scheduled_action_name  = "${var.cluster_name}-scale_in_at_night"
  min_size = 2
  max_size = 10
  desired_capacity = 2
  recurrence = "0 17 * * *"
}