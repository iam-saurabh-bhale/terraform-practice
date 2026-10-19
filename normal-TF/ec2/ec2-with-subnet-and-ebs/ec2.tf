# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Get details for each subnet
data "aws_subnet" "default" {
  for_each = toset(data.aws_subnets.default.ids)
  id       = each.value
}

# Select a default subnet with a public IPv4 address
resource "aws_instance" "simple" {
  ami           = "ami-0567589d25e06853e"
  instance_type = "t3.micro"

  # Select a default subnet
  subnet_id = [
    for subnet in data.aws_subnet.default :
    subnet.id
    if subnet.default_for_az && subnet.map_public_ip_on_launch
  ][0]

  # Enable public IP
  associate_public_ip_address = true

  tags = {
    Name = "Simple-EC2-Public"
  }

  # Primary EBS volume
  root_block_device {
    volume_size           = 15
    volume_type           = "gp3"
    delete_on_termination = true
  }
}

# Additional EBS volume
resource "aws_ebs_volume" "extra_volume" {
  size              = 10
  type              = "gp3"
  availability_zone = aws_instance.simple.availability_zone

  tags = {
    Name = "extra_volume"
  }
}

# Attach additional EBS volume
resource "aws_volume_attachment" "extra_attachment" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.extra_volume.id
  instance_id = aws_instance.simple.id
}

# Display public IP
output "ec2_public_ip" {
  value = aws_instance.simple.public_ip
}

# Display private IP
output "ec2_private_ip" {
  value = aws_instance.simple.private_ip
}