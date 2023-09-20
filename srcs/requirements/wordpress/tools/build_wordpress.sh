#!/bin/bash

sleep 15

if [-f ./wp-config.php]; then
	echo "Wordpress is already installed"
else
	echo "downloading and extracting wordpress for $DOMAIN_NAME"
	# wget https://wordpress.org/latest.tar.gz
	wp core download --allow-root
	wp db create --allow-root
	wp config create --dbname=$MYSQL_DATABASE --dbuse=$MYSQL_USER --dbpass --dnhost --allow-root
    wp core install --url=https://mteerlin.42.fr --title="WP-CLI" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
    # create another user who has enough permission to post/edit/delete (role = editor)
    wp user create $MYSQL_USER $MYSQL_EMAIL --user_pass=$MYSQL_PASSWORD --role=editor --allow-root
    #modify permissions securely on wp-config.php
    chmod 600 wp-config.php
fi
php-fpm7.3 -F






	# mv wordpress/* .
	# rm latest.tar.gz
	# rm -rf wordpress
	# echo "Download Coplete!"

	# sed -i "s/username_here/$WB_DATABASE_USER/g" wp-config-sample.php
	# sed -i "s/password_here/$WB_DATABASE_PASSWORD/g" wp-config-sample.php
	# sed -i "s/database_name_here/$WB_DATABASE_NAME/g" wp-config-sample.php
	# sed -i "s/local_here/$DOMAIN_NAME/g" wp-config-sample.php
	# cp wp-config-sample.php wp-config.php
# fi
