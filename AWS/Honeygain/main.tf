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

resource "aws_instance" "honeygain" {
  ami           = "ami-08f13e5792295e1b2"
  instance_type = "t2.micro"
  count         = 10
  associate_public_ip_address = true
  subnet_id = "subnet-0c178e33867e1670e"
  key_name = "honeygain" # Use the honeygain key pair
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
user_data = <<-EOF
            #!/bin/bash
            apt-get update
            apt-get install -y apache2
            echo "root:yxc_2023" | chpasswd
            # Install Docker
            apt-get update
            apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
            curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
            add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
            apt-get update
            apt-get install -y docker-ce docker-ce-cli containerd.io
            # Add user and give Docker permission
            useradd -m honeygain-user
            usermod -aG docker honeygain-user
            # Switch to honeygain-user and execute Docker command
            sudo -i -u honeygain-user bash << EOF2
            docker run honeygain/honeygain -tou-accept -email <EMAIL> -pass <PASSWORD> -device docker${count.index}
            EOF2
            EOF


  tags = {
    Name = "honeygain-${count.index + 1}"
  }
}
