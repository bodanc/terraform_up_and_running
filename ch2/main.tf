# an infrastructure platform, such as AWS, is a Terraform provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami                         = "ami-0f409bae3775dc8e5"
  instance_type               = "t3a.small"
  associate_public_ip_address = true

  tags = {
    Name = "tf-ec2-example"
  }
}

output "ec2_instance_availability_zone" {
  value = aws_instance.example.availability_zone
}

output "ec2_instance_subnet" {
  value = aws_instance.example.subnet_id
}
