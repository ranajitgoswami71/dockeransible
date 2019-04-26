## Ansible Provisioning EC2 hosts

**Usage:**

Create a variables file using *ec2_vars/sample.yml* as a template.

E.g. 

    cp ec2_vars/sample.yml ec2_vars/dockeransible.yml
    
After setting all variables, run it:

ansible-playbook -vv -i localhost, -e "type=dockeransible" provision-ec2.yml

First demo
