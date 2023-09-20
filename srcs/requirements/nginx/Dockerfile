FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl vim

# COPY ./index.html /var/www/html

RUN mkdir -p /etc/nginx/ssl \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
	-out /etc/nginx/ssl/mteerlin.crt \
	-keyout /etc/nginx/ssl/mteerlin.key \
	-subj "/C=NL/L=Amsterdam/O=Codam Coding College/OU=mteerlin/CN=mteerlin"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]