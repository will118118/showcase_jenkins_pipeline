terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

#resource "aws_ami" "example" {
#  name                = "terraform-example"
#  virtualization_type = "hvm"
#  root_device_name    = "/dev/xvda"

# ebs_block_device {
#    device_name = "/dev/xvda"
#    snapshot_id = "snap-xxxxxxxx"
#    volume_size = 8
#  }
#}

resource "aws_key_pair" "deployer" {
  key_name   = "will-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "allow_jenkins" {
  name        = "allow_jenkins"
  description = "Allow 8080 inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "8080 from anywhere"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "allow_jenkins"
  }
}

resource "aws_instance" "jenkins" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  #user_data              = file("jenkins.sh")
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_jenkins.id]

  tags = {
    Name = "jenkins-test"
  }
  depends_on = [
    aws_security_group.allow_jenkins
  ]
}
