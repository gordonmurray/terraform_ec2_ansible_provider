resource "ansible_host" "host" {
  name   = aws_instance.webserver.public_ip
  groups = ["webserver"]
}

resource "ansible_playbook" "playbook" {
  playbook                = "./playbook.yml"
  name                    = aws_instance.webserver.public_ip
  replayable              = true
  ignore_playbook_failure = true

  extra_vars = {
    example_variable             = "Some variable"
    ansible_hostname             = aws_instance.webserver.public_ip
    ansible_user                 = "ubuntu"
    ansible_ssh_private_key_file = "~/.ssh/id_rsa"
    ansible_python_interpreter   = "/usr/bin/python3"
  }

  depends_on = [
    aws_instance.webserver
  ]
}