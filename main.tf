provider "aws" {
  region = "ap-south-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "web" {
  ami                    = "ami-0f918f7e67a3323f0"
  instance_type          = "t2.micro"
  
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> ip_list.txt"
  }
}

resource "aws_security_group" "tf_sg" {
  name        = "tf_sg15"
  description = "Allow HTTPS to web server"
  vpc_id      = "vpc-05bdcc8880aab85ab"

  ingress {
    from_port   = 443
    to_port     = 443
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
