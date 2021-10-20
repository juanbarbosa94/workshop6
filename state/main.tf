terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.0"
    }
  }
}
#Each terraform block can contain a number of settings related to Terraform's behavior.
#Only constant values can be used
#Specifies which versions of Terraform can be used with your configuration.

provider "aws" {
  region = var.region 

}

resource "aws_instance" "workshop6app-mentor" {  
  instance_type     = "t2.micro"
  tags = {
    Name = "${var.instance_name}-${var.owner}"  
  }
  availability_zone = "us-east-1a" 
  ami = var.images["${var.region}"]
  vpc_security_group_ids = [aws_security_group.sg-workshop6-instance.id]
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              echo "<h1>Welcome to the Workshop6!</h1>" > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
              EOF
}

resource "aws_security_group" "sg-workshop6-instance" {
  name = "${var.owner}-sg-instance"
  tags = {
    Name = "${var.owner}-sg-instance"
  }
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
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
}
