### install mongodb client to load data
### setup mongo repo file

vim /etc/yum.repos.d/mongo.repo

### add to repo file

[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/
enabled=1
gpgcheck=0

dnf install mongodb-mongosh -y

### load master data information
mongosh --host 3.239.212.114 </app/db/master-data.js