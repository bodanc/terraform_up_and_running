# an infrastructure platform, such as AWS, is a Terraform provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "tf_ec2_ex1" {
  ami                         = "ami-0261755bbcb8c4a84"
  instance_type               = "t3a.small"
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.sec_gr_ex1.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "tf-ec2-ex1"
  }
}

resource "aws_security_group" "sec_gr_ex1" {
  name = "tf-sec_gr_ex1"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

output "ec2_instance_availability_zone" {
  value = aws_instance.tf_ec2_ex1.availability_zone
}

output "ec2_instance_public_ip" {
  value = aws_instance.tf_ec2_ex1.public_ip
}
