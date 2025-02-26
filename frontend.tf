resource "aws_instance" "frontend" {
  ami           = "ami-09c813fb71547fc4f"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0740e8c441e48cb53"]

  tags = {
    Name = "frontend"
  }
  /*provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ec2-user"
      password = "DevOps321"
      host     = self.public_ip
    }
    inline = [
      "pip3.11 install ansible",
      "ansible-pull -i localhost, -U https://github.com/mas123shaik/mas_roboshop_ansible roboshop.yml -e component_name=frontend -e env=dev",
    ]
  }*/
}
resource "aws_route53_record" "frontend" {
  zone_id = "Z02101962RY3FU3U9KSR5"
  name    = "frontend-dev"
  type    = "A"
  ttl     = 10
  records = [aws_instance.frontend.private_ip]
}
resource "null_resource" "frontend" {
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ec2-user"
      password = "DevOps321"
      host     = aws_instance.frontend.private_ip
    }
    inline = [
      "sudo pip3.11 install ansible",
      "ansible-pull -i localhost, -U https://github.com/mas123shaik/mas_roboshop_ansible roboshop.yml -e component_name=frontend -e env=dev",
    ]
  }
}