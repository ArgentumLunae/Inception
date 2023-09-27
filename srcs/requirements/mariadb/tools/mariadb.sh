#!/bin/bash

mysql_install_db
/etc/init.d/mariadb start


if [ -f "var/lib/mysql/$MYSQL_DATABASE" ]
then
	echo "Database good and ready."
else

mysql_secure_installation <<END

Y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
n
Y
Y
END

# echo "attempting to create database with user"
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

fi

/etc/init.d/mariadb stop

exec "$@"

