resource "aws_instance" "simple" {
  ami           = "ami-0567589d25e06853e"
  instance_type = "t3.micro"
  tags = {
    Name = "Simple EC2 with Volume"
  }
  root_block_device {
    volume_size           = 15
    volume_type           = "gp3"
    delete_on_termination = true
  }
}

resource "aws_ebs_volume" "extra_volume" {
  size              = 10
  type              = "gp3"
  availability_zone = aws_instance.simple.availability_zone
  tags = {
    Name = "extra_volume"
  }
}

resource "aws_volume_attachment" "extra_attachment" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.extra_volume.id
  instance_id = aws_instance.simple.id
}