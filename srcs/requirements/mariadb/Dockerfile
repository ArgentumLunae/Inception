FROM debian:bookworm

# create working directory
RUN mkdir -p /mariadb
WORKDIR /mariadb

# install mariadb
RUN	apt update && apt install -y mariadb-server

EXPOSE 3306

# define metadata
LABEL vesrion="1.0"
LABEL description="MariaDB Server"

HEALTHCHECK --start-period=5m \
	CMD mariadb -e 'SELECT @@datadir;' || exit 1

CMD ["mariadb"]