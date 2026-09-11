- Install mysql client
`dnf install mysql -y `
- Load schema to the database
`mysql -h mysql.jirawiser.online -uroot -pRoboShop@1 < /app/db/schema.sql`
- Create app user
`mysql -h mysql.jirawiser.online -uroot -pRoboShop@1 < /app/db/app-user.sql `
- Load master data 
`mysql -h mysql.jirawiser.online -uroot -pRoboShop@1 < /app/db/master-data.sql`
- Restart shipping service
`systemctl restart shipping`