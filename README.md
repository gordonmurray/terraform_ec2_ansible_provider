# Ansible provider for Terraform

A small example of using Terraform to create an EC2 instance and using the [Ansible Provider for Terraform](https://registry.terraform.io/providers/ansible/ansible/latest/docs) to run a Playbook to install nginx.

This isn't intended for production use, just to show how the Ansible provider works.

The main parts to point out are in the file called `ansible.tf`.

The following resource creates a host that Ansible can use and its populated with group called 'webserver' and the IP of the EC2 instance that Terraform will create.

```
resource "ansible_host" "host" {
  name   = aws_instance.webserver.public_ip
  groups = ["webserver"]
}
```

The playbook resource is below. It includes the Ansible playbook YML file to run and passes some extra vars to facilitate the connection. I'd highly recommend setting the `ignore_playbook_failure` parameter to `true`. If there is an issue in your Ansible playbook, Terraform will continue its usual steps and you can debug the Ansible playbook separately. If you omit the value or set it to false, you'll get unhelpful errors returned from the Provider that don't help debug the problem.

```
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

  depends_on = [aws_security_group_rule.webserver_ssh]
}
```



### How to use this project

Tested using Terraform v1.5.6 and Ansible v2.14.2.

Once you have cloned the repository locally, create a file in the same directory called `terraform.tfvars` with the following content:

```
# terraform.tfvars
vpc_id          = "vpc-xxxxx" # The VPC ID you'd like to deploy in to
subnet          = "subnet-xxxxx"  # A subnet within the VPC to use
self_ip_address = "123.123.123.123" # Your public IP address so you can SSH in to the resulting webserver
```

One you have your variables set, initialize and run Terraform using:

```
terraform init
terraform plan
terraform apply
```

### Useful debugging tips

Enable Ansible log - this will help you see any Ansible specific errors

```
export ANSIBLE_LOG_PATH=/path/to/ansible.log
```


Test running the Ansible Playbook outside of Ansible with:

```
ansible-playbook playbook.yml -e "ansible_host=IP_ADDRESS" -e "ansible_ssh_private_key_file=/path/to/file.pem" --user ubuntu
```

### Estimated cost

```
Project: gordonmurray/terraform_ec2_ansible_provider

 Name                                                  Monthly Qty  Unit   Monthly Cost

 aws_instance.webserver
 ├─ Instance usage (Linux/UNIX, on-demand, t4g.small)          730  hours        $13.43
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                       10  GB            $1.10

 OVERALL TOTAL                                                                   $14.53
──────────────────────────────────
8 cloud resources were detected:
∙ 1 was estimated, it includes usage-based costs, see https://infracost.io/usage-file
∙ 7 were free:
  ∙ 5 x aws_security_group_rule
  ∙ 1 x aws_key_pair
  ∙ 1 x aws_security_group
```