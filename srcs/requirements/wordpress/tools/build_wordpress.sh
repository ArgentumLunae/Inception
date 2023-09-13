#!/bin/bash

if [-f ./wp-config.php]; then
	echo "Wordpress is already downloaded"
else
	echo "downloading and extracting wordpress for $DOMAIN_NAME"
	wget https://wordpress.org/latest.tar.gz
	tar -xvzf latest.tar.gz
	mv wordpress/* .
	rm latest.tar.gz
	rm -rf wordpress
	echo "Download Coplete!"

	sed -i "s/username_here/$WB_DATABASE_USER/g" wp-config-sample.php
	sed -i "s/password_here/$WB_DATABASE_PASSWORD/g" wp-config-sample.php
	sed -i "s/database_name_here/$WB_DATABASE_NAME/g" wp-config-sample.php
	sed -i "s/local_here/$DOMAIN_NAME/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php
fi
