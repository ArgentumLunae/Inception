#!/bin/bash

mysql_install_db
/etc/init.d/mariadb start


if [ -f "var/lib/mysql/$MYSQL_DATABASE" ]
then
	echo "Database good and ready."
else

cat << END > /usr/local/bin/mariadb_install.expect
#!/usr/lib/expect

spawn sudo mariadb-secure-installation
expect "Enter current password for root (enter for none):"
send "\r"
expect "Switch to unix_socket authentication \[Y/n\]"
send "n\r"
expect "Set root password? \[Y/n\]"
send "Y\r"
expect "New password:"
send "$MYSQL_ROOT_PASSWORD\r"
expect "Re-enter new password:"
send "$MYSQL_ROOT_PASSWORD\r"
expect "Remove anonymous users? \[Y/n\]"
send "Y\r"
expect "Disallow root login remotely? \[Y/n\]"
send "n\r"
expect "Remove test database and access to it? \[Y/n\]"
send "Y\r"
expect "Reload privilege tables now? \[Y/n\]"
send "Y\r"
expect eof
END

chmod +x /usr/local/bin/mariadb_install.expect

expect /usr/local/bin/mariadb_install.expect

# echo "attempting to create database with user"
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | sudo mysql -uroot
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | sudo mysql -uroot

fi

/etc/init.d/mariadb stop

exec "$@"

