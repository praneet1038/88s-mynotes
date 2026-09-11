- Install MySQL server


`dnf install mysql-server -y`

- Start service
```
systemctl enable mysqld
systemctl start mysqld  
```
- Change default root password

- check status
`netstat -lntp`