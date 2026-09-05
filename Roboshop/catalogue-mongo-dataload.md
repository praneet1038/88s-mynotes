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
mongosh --host 3.80.74.138 </app/db/master-data.js

### connect to db server
mongosh --host 3.80.74.138

### review databases & data loaded
show dbs
use catalogue
show collections
## should all types of robots i
db.products.find()