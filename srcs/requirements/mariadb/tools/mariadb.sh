#!/bin/bash

mysql_install_db
mysql_upgrade
/etc/init.d/mysql start

if [ -d "var/lib/mysql/$MYSQL_DATABASE" ]
then
	echo "Database good and ready."
else


# chown -R mysql /var/lib/mysql

# nohup /usr/bin/mariadbd-safe --user=root --datadir=/var/lib/mysql > /dev/null &
# bg_pid=$!


# echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot
# echo "installing mysql"

mysql_secure_installation --protocol=TCP <<END

Y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
n
Y
Y
END

# echo "mysql finished installing"

# echo "attempting to create database with user"
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

kill $bg_pid

fi

/etc/init.d/mysql stop

exec "$@"

