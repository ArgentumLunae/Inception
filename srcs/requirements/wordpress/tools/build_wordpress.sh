#!/bin/bash

sleep 15

if [ -f wp-config.php ]; then
	echo "Wordpress is already installed"
else
	echo "downloading and extracting wordpress for $DOMAIN_NAME"
	# wget https://wordpress.org/latest.tar.gz
	wp core download --allow-root
	wp db create --allow-root
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST --allow-root
    wp core install --url=https://mteerlin.42.fr --title="WP-CLI" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
    
	# create another user who has enough permission to post/edit/delete (role = editor)
    wp user create $MYSQL_USER $MYSQL_EMAIL --user_pass=$MYSQL_PASSWORD --role=editor --allow-root
    
	#modify permissions securely on wp-config.php
    chmod 600 wp-config.php
fi
php-fpm7.3 -F
