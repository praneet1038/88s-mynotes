# Setup Catalogue
### Install Node.js 20
dnf module list nodejs
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

### add application user
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop

### create directory to store application
mkdir /app
### download app 
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip 
cd /app
### unzip app file 
unzip /tmp/catalogue.zip

### install dependencies
cd /app 
npm install 

### setup Systemctl catalogue service
vim /etc/systemd/system/catalogue.service

### copy to catalogue.service file and update mongodb IP
[Unit]
Description = Catalogue Service

[Service]
User=roboshop
Environment=MONGO=true
// highlight-start
Environment=MONGO_URL="mongodb://3.80.74.138:27017/catalogue"
// highlight-end
ExecStart=/bin/node /app/server.js
SyslogIdentifier=catalogue

[Install]
WantedBy=multi-user.target

### reload daemon

systemctl daemon-reload

## start the catalogue service
systemctl enable catalogue
systemctl start catalogue

## to check log
journalctl -u catalogue  | grep catalogue











