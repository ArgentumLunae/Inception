FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx && apt-get install -y openssl vim curl

RUN mkdir -p /etc/nginx/ssl
RUN	openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
	-out /etc/nginx/ssl/mteerlin.crt \
	-keyout /etc/nginx/ssl/mteerlin.key \
	-subj "/C=NL/L=Amsterdam/O=Codam Coding College/OU=mteerlin/CN=mteerlin"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]