- Install module maven

    `dnf install maven -y`
- Add app user

    `useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop`
- Download application
```bash
mkdir /app 

curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip 
```
- Extract application to /app
```cd /app 
unzip /tmp/shipping.zip
```

- Configure application (download dependencies & build application)
```
cd /app 
mvn clean package 
mv target/shipping-1.0.jar shipping.jar 
```

- Create shipping service
`vim /etc/systemd/system/shipping.service`
- Configure shipping service
```
[Unit]
Description=Shipping Service

[Service]
User=roboshop
// highlight-start
Environment=CART_ENDPOINT=<CART-SERVER-IPADDRESS>:8080
Environment=DB_HOST=<MYSQL-SERVER-IPADDRESS>
// highlight-end
ExecStart=/bin/java -jar /app/shipping.jar
SyslogIdentifier=shipping

[Install]
WantedBy=multi-user.target
```
- Start shipping service
```
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping
```
