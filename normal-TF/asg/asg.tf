resource "aws_autoscaling_group" "web_asg" {
  name = "terraform-web-asg"

  min_size         = 1
  desired_capacity = 1
  max_size         = 2

  vpc_zone_identifier = var.private_subnet_ids

  target_group_arns = [
    aws_lb_target_group.web_tg.arn
  ]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.web_template.id
    version = tostring(aws_launch_template.web_template.latest_version)
  }

  tag {
    key                 = "Name"
    value               = "terraform-asg-web"
    propagate_at_launch = true
  }

  depends_on = [
    aws_lb_listener.http
  ]
}