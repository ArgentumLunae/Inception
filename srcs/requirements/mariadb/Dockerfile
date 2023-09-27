#!/bin/bash

FROM debian:bookworm

# install mariadb
RUN	apt-get update \
	&& apt-get install -y mariadb-server \
	mariadb-client \
	vim procps expect\
	&& rm -rf /va/lib/apt/lists/*

EXPOSE 3306

RUN rm -f /etc/my.cnf ~/.my.cnf
COPY conf/mysql.conf ~/.my.cnf

RUN mkdir -p /var/run/mysqld 
RUN chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh

RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

CMD ["mysqld", "--bindaddress=0.0.0.0"]