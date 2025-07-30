provider "aws" {
  region = "ap-south-1"
  access_key = ""
  secret_key = ""
}

resource "aws_key_pair" "example" {
  key_name   = "key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "web" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = local.instance_type
  key_name      = aws_key_pair.example.key_name
}
provisioner "local-exec" {
    command = "echo$ {self.public_ip} >> ip_list.txt"
}
resource "aws_security_group" "tf_sg" {
  name        = "tf_sg"
  description = "Allow HTTPS to web server"
  vpc_id      = "vpc-05bdcc8880aab85ab"
}
