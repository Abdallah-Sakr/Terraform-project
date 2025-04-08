output "public_ip" {
  value = [aws_instance.web_server.public_ip, aws_instance.web_server2.public_ip]
}

output "instance_id" {
  value = [aws_instance.web_server.id, aws_instance.web_server2.id]
}
