
all: down vol up

up:
	docker compose -f srcs/docker-compose.yml up --build -d --remove-orphans --force-recreate

down:
	docker compose -f srcs/docker-compose.yml down

vol:
	mkdir -p /Users/mteerlin/data/wordpress/

clean:
	docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);

re:
	clean
	make

.PHONY: all up down clean re