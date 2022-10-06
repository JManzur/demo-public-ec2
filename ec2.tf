#Grabbing latest Linux 2 AMI
data "aws_ami" "linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Demo EC2 Deploy
resource "aws_instance" "demo-ec2" {
  ami                         = data.aws_ami.linux2.id
  instance_type               = var.instance_type["type1"]
  subnet_id                   = aws_subnet.demo_public.id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.web_server.id]
  associate_public_ip_address = true

  user_data = <<EOF
  #!/bin/bash
  yum update -y
  yum install httpd -y
  sleep 10
  echo "<html><h1>Hellow Word from $(hostname -f)</h1></html>" >> /var/www/html/index.html
  sleep 5
  systemctl start httpd
  systemctl enable httpd
  EOF

  tags = { Name = "${var.name_prefix}-ec2" }

  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
    tags                  = { Name = "${var.name_prefix}-ebs" }
  }

  provisioner "remote-exec" {
    inline = ["echo 'SSH connection established'"]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.local_ssh_key)
      host        = aws_instance.demo-ec2.public_ip
    }
  }
}