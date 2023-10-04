#!/bin/bash

sleep 100

if [ -f ./download-complete ]; then
	echo "wordpress already downloaded"
else
	echo "downloading and extracting wordpress for $DOMAIN_NAME"
	wp core download --allow-root
	touch download-complete
fi

if [ -f wp-config.php ]; then
	echo "Wordpress is already installed"
else
	# wget https://wordpress.org/latest.tar.gz
	echo "config create"
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST --allow-root --skip-check
	echo "config created"
	sleep 1
	echo "db create"
	sudo wp db create --allow-root
	echo "db created"
	sleep 1
	echo "core install"
    wp core install --url=https://mteerlin.42.fr --title="WP-CLI" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
	echo "core installed"
	sleep 1
    
	# create another user who has enough permission to post/edit/delete (role = editor)
	echo "user create"
    wp user create $MYSQL_USER $MYSQL_EMAIL --user_pass=$MYSQL_PASSWORD --role=editor --allow-root
	echo "user created"

	#modify permissions securely on wp-config.php
	echo "permissions"
    chmod 600 wp-config.php
	echo "permissioned"
fi

php-fpm8.2 -F
