FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl

COPY ./index.html /var/www/html

RUN mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/mteerlin.key \
	-out /etc/nginx/ssl/mteerlin.crt \
	-subj "/C=NL/ST=Noord Holland/L=Amsterdam/O=Codam Coding College/OU=mteerlin/CN=mteerlin.codam.nl"

COPY /config/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
