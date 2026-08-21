# Setup Catalogue
### Install Node.js 20
dnf module list nodejs
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

### add app user
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop

### create directory to store app
mkdir /app
### download app 
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip 
cd /app
### unzip app file 
unzip /tmp/catalogue.zip

### install dependencies
cd /app 
npm install 

### setup Systemctl
vim /etc/systemd/system/catalogue.service
### copy to catalogue.service file and update mongodb IP

[Unit]
Description = Catalogue Service

[Service]
User=roboshop
Environment=MONGO=true
// highlight-start
Environment=MONGO_URL="mongodb://<MONGODB-SERVER-IPADDRESS>:27017/catalogue"
// highlight-end
ExecStart=/bin/node /app/server.js
SyslogIdentifier=catalogue

[Install]
WantedBy=multi-user.target

### reload daemon

systemctl daemon-reload









