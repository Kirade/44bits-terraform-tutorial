data "aws_security_group" "default" {
  id = "sg-0bfb25745a0e5fc19"
}

resource "aws_key_pair" "web_admin" {
  key_name = "web_admin"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "ssh" {
  name = "allow_ssh_from_all"
  description = "Allow SSH port from all"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami = "ami-03b42693dc6a7dc35"
  instance_type = "t2.micro"
  key_name = aws_key_pair.web_admin.key_name
  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    data.aws_security_group.default.id
  ]
}
