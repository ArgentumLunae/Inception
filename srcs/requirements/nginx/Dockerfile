FROM debian:bookworm-slim

RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y nginx

COPY ./conf/nginx.conf /etc/nginx/conf.d

RUN mkdir -p /run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]