#!/bin/bash

FROM debian:bookworm

# install mariadb
RUN	apt-get update \
	&& apt-get install -y mariadb-server \
	mariadb-client \
	vim  procps\
	&& rm -rf /va/lib/apt/lists/*

RUN mkdir -p /home/mteerlin/data/mariadb/
RUN chmod 755 /home/mteerlin/data/mariadb/

EXPOSE 3306

RUN mkdir -m 777 -p /var/run/mysqld && \
	chown -R mysql:mysql var/run/mysqld


COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh

RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

CMD ["mysqld", "--bindaddress=0.0.0.0"]