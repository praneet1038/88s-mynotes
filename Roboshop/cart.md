## Launch new instance for cart 
## install nodejs 20v
```dnf module disable nodejs
dnf module enable nodejs:20
dnf module install nodejs
```

## Extract cart application to /app
```
mkdir /app
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app 
unzip /tmp/cart.zip
```
## Setup Cart service
## update redis & catalogue ip addresses
```
vim /etc/systemd/system/cart.service
systemctl daemon-reload
systemctl enable cart
systemctl start cart

```

## go back to frontend to configure user & cart app urls in nginx.conf

## Troubleshooting
