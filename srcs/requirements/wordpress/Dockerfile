FROM debian:bookworm

RUN	apt-get update && \
	apt-get install -y \
	wget curl php php-fpm php-phar

RUN wget https://wordpres.org/latest.tar.gz && \
	tar -xvzf latest.tar.gz && \
	rm latest.tar.gz && \
	mv wordpress /var/www/html/


CMD []
