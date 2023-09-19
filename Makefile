
all: down up

up:
	docker compose -f srcs/docker-compose.yml up --build -d --remove-orphans --force-recreate --timeout 1300

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune	-f --all --volumes

re:
	clean
	make

.PHONY: all up down clean re