## install python
`dnf install python3 gcc python3-devel -y`

## Configure app
## Add application user


## app directory 
mkdir /app

## Extract application
```
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip 
cd /app 
unzip /tmp/payment.zip
```
## create payment.service
`vim /etc/systemd/system/payment.service`

```
[Unit]
Description=Payment Service

[Service]
User=root
WorkingDirectory=/app
// highlight-start
Environment=CART_HOST=<CART-SERVER-IPADDRESS>
Environment=CART_PORT=8080
Environment=USER_HOST=<USER-SERVER-IPADDRESS>
Environment=USER_PORT=8080
Environment=AMQP_HOST=<RABBITMQ-SERVER-IPADDRESS>
// highlight-end
Environment=AMQP_USER=roboshop
Environment=AMQP_PASS=roboshop123

ExecStart=/usr/local/bin/uwsgi --ini payment.ini
ExecStop=/bin/kill -9 $MAINPID
SyslogIdentifier=payment

[Install]
WantedBy=multi-user.target
```

## Start service

```
systemctl daemon-reload
systemctl enable payment 
systemctl start payment
```

### status check
`curl http://localhost:8080/health`