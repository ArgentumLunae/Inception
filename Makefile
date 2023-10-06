
all: down up

up:
	docker-compose -f srcs/docker-compose.yml up --build -d --remove-orphans --force-recreate --timeout 1300

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune	-f --all --volumes

fclean: clean
	docker volume rm srcs_db-volume
	docker volume rm srcs_wordpress-volume
	rm -rf /home/mteerlin/data/mysql
	rm -rf /home/mteerlin/data/wordpress

# docker-setup:
# 	sh setup/dockersetup.sh

setup:
	$(if $(shell grep "mteerlin.42.fr" /etc/hosts), echo "Domain already hosted", sudo sh -c 'sudo echo "127.0.0.1 mteerlin.42.fr" >> /etc/hosts')
	mkdir -p /home/mteerlin/data/mysql
	mkdir -p /home/mteerlin/data/wordpress

re:	fclean
	make

.PHONY: all up down clean fclean docker-setup setup re