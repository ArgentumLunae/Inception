#!/bin/bash

if [ -f "var/lib/mysql/$WP_DATABASE" ]
then
	echo "Database good and ready."
else
mariadb-install-db

# /etc/init.d/mysql start

# chown -R mysql /var/lib/mysql

# nohup /usr/bin/mariadbd-safe --user=root --datadir=/var/lib/mysql > /dev/null &
# bg_pid=$!

echo "installing mysql"
mysql_secure_installation <<END

Y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
n
Y
Y
END

echo "mysql finished installing"
sleep 5

# echo "GRANT ALL ON *.* TO '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

echo "CREATE DATABASE IF NOT EXISTS $WP_DATABASE; GRANT ALL ON $WP_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

kill $bg_pid

sleep 2

fi

/etc/init.d/mysql stop

exec "$@"

