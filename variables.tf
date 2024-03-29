# AWS Region: North of Virginia
variable "aws_region" {
  type = string
}

variable "aws_profile" {
  type = string
}

# SSH Key-Pair 
variable "key_name" {
  type = string
}

# SSH Key-Pair local file
variable "local_ssh_key" {
  type = string
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

/* Tags Variables */
#Use: tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-place-holder" }, )
variable "project-tags" {
  type = map(string)
  default = {
    service     = "Demo EC2",
    environment = "POC",
    DeployedBy  = "JManzur - https://jmanzur.com/"
  }
}

#Use: tags = { Name = "${var.name_prefix}-lambda" }
variable "name_prefix" {
  type = string
}