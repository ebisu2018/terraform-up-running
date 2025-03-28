resource "aws_launch_template" "instance-tpl" {
  image_id = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.instance-sg.id]

  user_data = base64encode(file(var.user_data_script))
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "asg-group" {
  name = "${var.cluster_name}-${aws_launch_template.instance-tpl.name}"
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired
  target_group_arns = var.target_group_arns
  health_check_type = "ELB"

  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id = aws_launch_template.instance-tpl.id
  }
}

resource "aws_autoscaling_schedule" "scale_out_during_busy_hours" {
  count = var.enable_autoscaling ? 1 : 0

  autoscaling_group_name = aws_autoscaling_group.asg-group.name
  scheduled_action_name  = "${var.cluster_name}-scale-out-during-busy-hours"
  min_size = 2
  max_size = 10
  desired_capacity = 10
  recurrence = "0 9 * * *"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  count = var.enable_autoscaling ? 1 : 0

  autoscaling_group_name = aws_autoscaling_group.asg-group.name
  scheduled_action_name  = "${var.cluster_name}-scale_in_at_night"
  min_size = 2
  max_size = 10
  desired_capacity = 2
  recurrence = "0 17 * * *"
}

resource "aws_security_group" "instance-sg" {
  name = "${var.cluster_name}-sg"
}


resource "aws_security_group_rule" "allow_instance_inbound" {
  from_port         = local.any_port
  protocol          = local.any_protocol
  security_group_id = aws_security_group.instance-sg.id
  to_port           = local.any_port
  type              = "ingress"
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_instance_outbound" {
  from_port         = local.any_port
  protocol          = local.any_protocol
  security_group_id = aws_security_group.instance-sg.id
  to_port           = local.any_port
  type              = "egress"
  cidr_blocks = local.all_ips
}