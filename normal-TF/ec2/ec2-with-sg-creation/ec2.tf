resource "aws_instance" "simple" {
  ami           = "ami-0567589d25e06853e"
  instance_type = "t3.micro"
  tags = {
    Name = "simple-ec2"
    Env = "study"
  }
  root_block_device {
    volume_size           = 15
    volume_type           = "gp3"
    delete_on_termination = true
  }
  vpc_security_group_ids = [ aws_security_group.ec2_sg.id ]
}
