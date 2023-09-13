resource "aws_launch_configuration" "example" {
  image_id        = "ami-0261755bbcb8c4a84"
  instance_type   = "t3a.medium"
  security_groups = [aws_security_group.sec_gr_ex1.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  # prevents a deadlock, as terraform would be unable to delete the old (immutable) aws_launch_configuration
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name

  availability_zones = ["us-east-1d"]

  min_size = 2
  max_size = 3

  tag {
    key                 = "Name"
    value               = "tf-asg-ex"
    propagate_at_launch = true
  }
}
