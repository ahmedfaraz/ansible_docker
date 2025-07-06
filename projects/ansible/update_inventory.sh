#!/bin/bash

# Navigate to terraform directory and apply configuration
cd terraform
terraform init
terraform apply -auto-approve

# Return to project root
cd ..

# Ensure Ansible inventory file is updated
ansible-inventory -i ansible/inventory/hosts.yml --list