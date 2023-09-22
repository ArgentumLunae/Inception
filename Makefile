
all: down up

up:
	docker-compose -f srcs/docker-compose.yml up --build -d --remove-orphans --force-recreate --timeout 1300

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	docker volume rm srcs_db-volume srcs_wordpress-volume
	docker system prune	-f --all --volumes

re:
	make clean
	make

.PHONY: all up down clean fclean re