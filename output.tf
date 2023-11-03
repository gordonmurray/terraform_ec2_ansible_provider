output "webserver_ips" {
  value = [for instance in aws_instance.webserver : instance.public_ip]
}
