resource "ansible_host" "host" {
  count  = length(aws_instance.webserver.*.public_ip)
  name   = aws_instance.webserver[count.index].public_ip
  groups = ["webserver"]
}

resource "ansible_playbook" "playbook" {
  count                   = length(aws_instance.webserver.*.public_ip)
  playbook                = "./playbook.yml"
  name                    = aws_instance.webserver[count.index].public_ip
  replayable              = true
  ignore_playbook_failure = true

  extra_vars = {
    example_variable             = "Some variable"
    ansible_hostname             = aws_instance.webserver[count.index].public_ip
    ansible_user                 = "ubuntu"
    ansible_ssh_private_key_file = "~/.ssh/id_rsa"
    ansible_python_interpreter   = "/usr/bin/python3"
  }

  depends_on = [aws_security_group_rule.webserver_ssh]
}
