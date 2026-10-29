output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer"
  value       = aws_lb.web_alb.dns_name
}

output "alb_url" {
  description = "URL to access the web application"
  value       = "http://${aws_lb.web_alb.dns_name}"
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.web_template.id
}


output "target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.web_tg.arn
}