if [-d "var/lib/mysql/$WP_DATABASE_NAME"]
then
	echo "Database good and ready."
else
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql

	chown -R mysql /var/lib/mysql

	nohup /usr/bin/mariadb-safe --user=root --datadir=/var/lib/mysql > /dev/null &
	bg_pid=$!

	sleep 5

	mysql_secure_installation << HELLO

	Y
	Y
	$MYSQL_PASSWORD
	$MYSQL_PASSWORD
	Y
	n
	Y
	Y
HELLO

	sleep 5

	echo "GRANT ALL ON *.* TO"

