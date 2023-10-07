MYHOME = /home/argentumlunae

all: down setup up

up:
	docker-compose -f srcs/docker-compose.yml up --build -d --remove-orphans --force-recreate --timeout 1300

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune	-f --all --volumes

fclean: clean
	rm -rf $(MYHOME)/data/mysql
	rm -rf $(MYHOME)/data/wordpress
	docker volume rm srcs_db-volume
	docker volume rm srcs_wordpress-volume

# docker-setup:
# 	sh setup/dockersetup.sh

setup:
	$(if $(shell grep "mteerlin.42.fr" /etc/hosts), echo "Domain already hosted", sudo sh -c 'sudo echo "127.0.0.1 mteerlin.42.fr" >> /etc/hosts')
	mkdir -p $(MYHOME)/data/mysql
	mkdir -p $(MYHOME)/data/wordpress

re:	fclean
	make

.PHONY: all up down clean fclean docker-setup setup re