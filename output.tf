output "webserver_ip" {
  value = aws_instance.webserver.public_ip
}