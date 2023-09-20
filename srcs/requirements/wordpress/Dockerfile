#!/bin/bash

FROM debian:bookworm

RUN	apt-get update \
	&& apt-get install -y \
	wget curl bash php php-cgi php-fpm php-phar \
	php-mysql php-pdo php-gd php-cli php-mbstring \
	vim mariadb-server mariadb-client

RUN mkdir -p /home/mteerlin/data/wordpress/ \
	&& chmod 755 /home/mteerlin/data/wordpress/

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \ 
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp  
									#-cli


COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN mkdir -p /run/php && mkdir -p /var/www/html

COPY --chmod=755 ./tools/build_wordpress.sh /usr/local/bin/build_wordpress.sh
# ENTRYPOINT ["/usr/local/bin/build_wordpress.sh"]

WORKDIR /var/www/html

EXPOSE 9000

CMD ["/bin/bash", "/usr/local/bin/build_wordpress.sh", "--allow-root"]
# CMD ["/usr/sbin/php-fpm7.3", "-F"]
