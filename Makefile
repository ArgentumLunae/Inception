
all: down vol up

up:
	sudo docker compose -f srcs/docker-compose.yml up --build -d --remove-orphans --force-recreate

down:
	sudo docker compose -f srcs/docker-compose.yml down

vol:
	mkdir -p /home/mteerlin/data/wordpress/
	mkdir -p /home/mteerlin/data/mariadb/

clean:
	sudo docker stop $$(docker ps -qa);\
	sudo docker rm $$(docker ps -qa);\
	sudo docker rmi -f $$(docker images -qa);\
	sudo docker volume rm $$(docker volume ls -q);\
	sudo docker network rm $$(docker network ls -q);

re:
	clean
	make

.PHONY: all up down clean re