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
  ami           = data.aws_ami.ubuntu.id
  instance_type = local.instance_type
  key_name      = aws_key_pair.example.key_name
}
provisioner "local-exec" {
    command = "echo$ {self.public_ip} >> ip_list.txt"
}
