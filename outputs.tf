
output "ec2_public_ip_http" {
  value = "http://${aws_instance.demo-ec2.public_ip}"
  description = "The Apache URL so you can easily test the demo web page"
}

output "ec2_public_ip_ssh" {
  value = "ssh -i ${var.local_ssh_key} ec2-user@${aws_instance.demo-ec2.public_ip}"
  description = "The full SSH you need to run to connect to the instance"
}