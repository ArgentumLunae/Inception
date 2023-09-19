#!/bin/bash

FROM debian:bookworm

# install mariadb
RUN	apt-get update && \
	apt-get install -y mariadb-server \
	mariadb-client \
	vim && \
	rm -rf /va/lib/apt/lists/*

# RUN mkdir -p /home/mteerlin/Documents/data/mariadb/ \
# 	&& chmod 777 /home/mteerlin/Documents/data/wordpress/

# EXPOSE 3306

RUN mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql var/run/mysqld && \
	chmod 777 /var/run/mysqld


COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh
# COPY ./conf/wordpress.sql /usr/local/bin/

RUN chmod 777 /usr/local/bin/mariadb.sh
	#chmod +x /usr/local/bin/wordpress.sql

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

CMD ["mysqld", "--bindaddress=0.0.0.0"]