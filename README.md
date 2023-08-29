# terraform_ec2_ansible_provider
A small example of using the Ansible Provider for Terraform




### Useful debugging tips

Enable Ansible log - this will help you see any Ansible specific errors

```
export ANSIBLE_LOG_PATH=/path/to/ansible.log
```


Test running the Ansible Playbook outside of Ansible with:

```
ansible-playbook playbook.yml -e "ansible_host=IP_ADDRESS" -e "ansible_ssh_private_key_file=/path/to/file.pem" --user ubuntu
```
