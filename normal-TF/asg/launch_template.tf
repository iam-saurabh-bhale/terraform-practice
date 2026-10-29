resource "aws_launch_template" "web_template" {
  name_prefix   = "web-asg-template-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    set -euxo pipefail

    dnf install -y httpd

    cat > /var/www/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
      <head>
        <title>Terraform ASG Lab</title>
      </head>
      <body>
        <h1>Hello from Apache!</h1>
        <p>This EC2 instance was launched by an Auto Scaling Group.</p>
        <p>Served from a private subnet through an Application Load Balancer.</p>
        <p>Instance ID: <strong>INSTANCE_ID_PLACEHOLDER</strong></p>
      </body>
    </html>
    HTML

    TOKEN=$(curl -X PUT \
      "http://169.254.169.254/latest/api/token" \
      -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

    INSTANCE_ID=$(curl -s \
      -H "X-aws-ec2-metadata-token: $TOKEN" \
      http://169.254.169.254/latest/meta-data/instance-id)

    sed -i "s/INSTANCE_ID_PLACEHOLDER/$INSTANCE_ID/" \
      /var/www/html/index.html

    systemctl enable httpd
    systemctl start httpd
  EOF
  )

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "terraform-asg-web"
    }
  }

  tags = {
    Name = "terraform-web-launch-template"
  }
}