resource "aws_security_group" "web_server" {
  name        = "web_server"
  description = "SSH and HTTP"
  vpc_id      = aws_vpc.ec2_demo_vpc.id

  ingress {
    description = "SSH from Interney"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from Interney"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description      = "Allow Internet Out"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-sg" }, )
}