provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "web_server_sg" {
  name_prefix = "web-server-sg"
  vpc_id = "vpc-0bb73809d061191b1"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami           = "ami-08f13e5792295e1b2"
  instance_type = "t2.micro"
  count         = 3
  associate_public_ip_address = true
  subnet_id = "subnet-0c178e33867e1670e"
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y apache2
              echo "root:yxc_2023" | sudo chpasswd
              EOF

  tags = {
    Name = "example-instance-${count.index + 1}"
  }
}
