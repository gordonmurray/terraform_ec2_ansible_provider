resource "aws_key_pair" "key" {
  key_name   = "webserver"
  public_key = file("~/.ssh/id_rsa.pub")
}