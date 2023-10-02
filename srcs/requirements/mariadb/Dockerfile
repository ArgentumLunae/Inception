#!/bin/bash

FROM debian:bookworm

# install mariadb
RUN	apt-get update \
	&& apt-get install -y mariadb-server \
	mariadb-client \
	vim sudo expect\
	&& rm -rf /va/lib/apt/lists/*

EXPOSE 3306
RUN rm -f /etc/mysql/mariadb.cnf /etc/my.cnf ~/.my.cnf
COPY conf/mysql.conf /etc/mysql/mariadb.cnf

RUN mkdir -p /var/run/mysqld 
RUN chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh

RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

CMD ["/usr/bin/mariadbd-safe", "--user=root", "--datadir=/var/lib/mysql"]