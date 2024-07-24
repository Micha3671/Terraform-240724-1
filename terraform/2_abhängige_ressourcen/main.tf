provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "my_security_group" {
  name        = "SSH-und-HTTP-offen"
  description = "Allow SSH and HTTP from anywhere"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_instance" {
  ami           = "ami-01e444924a2233b07"
  instance_type = "t2.nano"

  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  tags = {
    Name = "Hallo-instance"
  }
}