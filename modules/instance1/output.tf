output "public_ip" {
  value = [aws_instance.web_server1.public_ip, aws_instance.web_server3.public_ip]
}

output "instance_id" {
  value = [aws_instance.web_server1.id, aws_instance.web_server3.id]
}
