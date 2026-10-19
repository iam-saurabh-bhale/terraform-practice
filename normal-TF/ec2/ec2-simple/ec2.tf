resource "aws_instance" "simple-ec2" {
    instance_type = "t3.micro"
    ami = "ami-0567589d25e06853e"
    tags = {
      name = "simple-ec2"
    }
}  
