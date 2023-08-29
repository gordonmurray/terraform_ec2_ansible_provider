# Ansible provider for Terraform

A small example of using Terraform to create an EC2 instance and using the [Ansible Provider for Terraform](https://registry.terraform.io/providers/ansible/ansible/latest/docs) to run a Playbook to install nginx.

This isn't intended for production use, just to show how the Ansible provider works.

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