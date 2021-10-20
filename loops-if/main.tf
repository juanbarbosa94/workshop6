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
  region = var.region # change with your assigned region

}

resource "aws_instance" "workshop6app-mentor" { #change the resource name with your name as suffix 
  instance_type     = "t2.micro"
  tags = {
    Name = "${var.instance_name}-${var.owner}" #change the name tag with your name as suffix 
  }
  availability_zone = "us-east-1a" # change with your assigned region
  ami = var.images["${var.region}"]
  #ami               = "ami-02e136e904f3da870" #For us-east-1
  #ami               = "ami-074cce78125f09d61" #For us-east-2
  #ami               = "ami-013a129d325529d4d" #For us-west-2
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
