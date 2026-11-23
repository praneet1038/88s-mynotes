# run ansible playbook to create mongodb, catalogue instances
ansible-playbook -i localhost, roboshop.yaml



# deploy mongodb
ansible-playbook -i inventory.ini mongodb.yaml