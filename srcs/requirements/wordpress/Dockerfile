FROM debian:bookworm

RUN	apt-get update && \
	apt-get install -y \
	wget curl php php-fpm php-phar 

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp-cli

WORKDIR /var/www/html

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN mkdir -p /run/php

COPY ./tools/build_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/build_wordpress.sh
ENTRYPOINT ["usr/local/bin/build_wordpress.sh"]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]
