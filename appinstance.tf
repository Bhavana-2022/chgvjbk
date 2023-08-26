resource "aws_key_pair" "key1" {
  key_name   = "key1-key"
  public_key = file(var.aws_key_pair)

}


data "aws_subnet" "web" {
  filter {
    name   = "tag:Name"
    values = [var.web]
  }
  depends_on = [aws_subnet.sub]
}

resource "aws_instance" "appserver" {
  ami                         = var.awsamiid
  associate_public_ip_address = true
  instance_type               = var.awsinstancetype
  key_name                    = aws_key_pair.key1.key_name
  vpc_security_group_ids      = [aws_security_group.websec.id]
  subnet_id                   = data.aws_subnet.web.id

  tags = {
    Name = "appserver"
  }

  depends_on = [aws_vpc.itsmyvpc, aws_subnet.sub, aws_key_pair.key1, data.aws_subnet.web, aws_security_group.websec]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.privatekey)
    host        = aws_instance.appserver.public_ip
  }


  provisioner "file" {
    source      = "nopcommerce.service"
    destination = "/home/ubuntu/nopcommerce.service"
  }
  provisioner "file" {
    source      = "nopcommerce.yaml"
    destination = "/home/ubuntu/nopcommerce.yaml"
  }
  provisioner "file" {
    source      = "default"
    destination = "/home/ubuntu/default"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install software-properties-common -y",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y",
      "echo nop_url > hosts",
      "ansible-playbook -i hosts nopcommerce.yaml"
    ]
  }

}