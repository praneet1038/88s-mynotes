## setup control node (ansible + inventory)
### on control node
`dnf install ansible -y`

Install dependencies for aws
`pip install botocore boto3`
### inventory.ini
Logically organized list of managed nodes 

### setup managed nodes
roboshop.yaml

### output
![alt text](image-1.png)


### install mongodb
mongodb.yaml

### output
![alt text](image.png)

### install catalogue
catalgoue.yaml

![alt text](image-2.png)



fatal: [mongodb-dev.jirawiser.online]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh: Warning: Permanently added 'mongodb-dev.jirawiser.online' (ECDSA) to the list of known hosts.\r\nec2-user@mongodb-dev.jirawiser.online: Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password).", "unreachable": true}



