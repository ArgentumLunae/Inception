#!/bin/bash

if [ -f "var/lib/mysql/$WP_DATABASE_NAME" ]
then
	echo "Database good and ready."
else
mariadb-install-db --user=mysql --datadir=/var/lib/mysql

/etc/init.d/mysql start

chown -R mysql /var/lib/mysql

nohup /usr/bin/mariadbd-safe --user=root --datadir=/var/lib/mysql > /dev/null &
bg_pid=$!

sleep 5

echo "installing mysql"
mysql_secure_installation <<END

Y
$MYSQL_PASSWORD
$MYSQL_PASSWORD
Y
n
Y
Y
END

echo "mysql finished installing"
sleep 5

echo "GRANT ALL ON *.* TO '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

kill $bg_pid

sleep 2

fi

exec "$@"

