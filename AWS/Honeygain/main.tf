provider "aws" {
  region = "eu-central-1"  # Ändern Sie die Region entsprechend Ihren Anforderungen
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16" # Hier geben Sie den CIDR-Block für den VPC an

  tags = {
    Name = "example-vpc"
  }
}

resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.example.id  # Hier geben Sie die ID des VPCs an, in dem Sie das Subnetz erstellen möchten
  cidr_block = "10.0.1.0/24"      # Hier geben Sie den CIDR-Block für das Subnetz an

  tags = {
    Name = "example-subnet"
  }
}

resource "aws_instance" "example" {
  ami           = "ami-08f13e5792295e1b2"  # Hier sollten Sie die AMI-ID angeben, die Sie verwenden möchten
  instance_type = "t2.micro"              # Hier sollten Sie den gewünschten Instanztyp angeben
  subnet_id     = aws_subnet.example.id  # Hier geben Sie die ID des Subnetzes an

  count = 2  # Legt die Anzahl der Instanzen fest, die bereitgestellt werden sollen

  tags = {
    Name = "example-instance"  # Ändern Sie den Namen entsprechend Ihren Anforderungen
  }
}