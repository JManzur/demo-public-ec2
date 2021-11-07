# AWS Region: North of Virginia
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

# SSH Key-Pair 
variable "key_name" {
  type    = string
  default = "PublicEC2Demo"
}

# SSH Key-Pair local file
variable "local_ssh_key" {
  type    = string
  default = "~/.ssh/PublicEC2Demo.pem"
}

# AMI: AWS Linux 2
variable "aws_ami_id" {
  type    = string
  default = "ami-087c17d1fe0178315"
}

#EC2 Instance type
#Use: instance_type = var.instance_type["type1"]
variable "instance_type" {
  type = map(string)
  default = {
    "type1" = "t2.micro"
    "type2" = "t2.small"
    "type3" = "t2.medium"
  }
}

### Tags Variables ###

variable "project-tags" {
  type = map(string)
  default = {
    service     = "Public-EC2-Demo",
    environment = "demo"
    owner       = "example@mail.com"
  }
}

variable "resource-name-tag" {
  type    = string
  default = "Public-EC2-Demo"
}