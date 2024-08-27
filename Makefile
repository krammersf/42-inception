# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fde-carv <fde-carv@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/23 15:25:32 by fde-carv          #+#    #+#              #
#    Updated: 2024/08/20 14:52:44 by fde-carv         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Colours
BLACK	=	\033[1;30m
RED		=	\033[1;31m
GREEN	=	\033[1;32m
YELLOW1	=	\033[0;33m
YELLOW	=	\033[1;33m
BLUE	=	\033[1;34m
MAGENTA	=	\033[1;35m
CYAN	=	\033[1;36m
WHITE	=	\033[0;37m
WHITE	=	\033[1;37m
RESET	=	\033[0m

# Config Variables
USER42_NAME 	=	fde-carv
WP_DATA			=	/home/$(USER42_NAME)/data/wordpress/
DB_DATA			=	/home/$(USER42_NAME)/data/mariadb/
DOMAIN_NAME		=	$(USER42_NAME).42.fr
PROJECT_NAME	=	inception-$(USER42_NAME) # Project name for docker-compose ==> the -p (flag)
COMPOSE_FILE	=	./srcs/docker-compose.yml

all: up

# start the building process
# create the wordpress and mariadb data directories.
# start the containers in the background and leaves them running
up: build
	@sudo mkdir -p $(WP_DATA)
	@sudo mkdir -p $(DB_DATA)
	@sudo sed -i "/127.0.0.1 $(DOMAIN_NAME)/d" /etc/hosts
	@sudo sh -c "echo '127.0.0.1 $(DOMAIN_NAME)' >> /etc/hosts"
	@docker compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) up -d
	@echo ""

down:
	@docker compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) down

build:
	@docker compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) build 

clean: down
	@echo "\n $(BLUE)##### $(RED)STOPPING ALL CONTAINERS $(BLUE)#####$(RESET)"
	@if [ -n "$$(docker ps -q)" ]; then docker stop $$(docker ps -q); fi

	@echo "\n $(BLUE)##### $(RED)REMOVING DOCKER $(BLUE)#####$(RESET)"
	@if [ -n "$$(docker ps -aq)" ]; then docker rm $$(docker ps -aq); fi

	@echo "\n $(BLUE)##### $(RED)REMOVING IMAGES $(BLUE)#####$(RESET)"
	@if [ -n "$$(docker images -aq)" ]; then docker rmi $$(docker images -aq); fi

	@echo "\n $(BLUE)##### $(RED)REMOVING VOLUMES $(BLUE)#####$(RESET)"
	@if [ -n "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); fi

	@echo "\n $(BLUE)##### $(RED)REMOVING DATA DIRECTORIES $(BLUE)#####$(RESET)"
	@if [ -d "$(WP_DATA)" ]; then sudo rm -rf $(WP_DATA); fi
	@if [ -d "$(DB_DATA)" ]; then sudo rm -rf $(DB_DATA); fi

	@echo "\n $(BLUE)##### $(RED)REMOVING HOSTS ENTRY $(BLUE)#####$(RESET)"
	@sudo sed -i "/127.0.0.1 $(DOMAIN_NAME)/d" /etc/hosts

	@echo ""
	@$(MAKE) --no-print-directory info

re: clean up
	
prune:
	docker system prune -a

info:
	@echo "\n$(CYAN) _______________________/ $(YELLOW)DOCKERS STATUS INFO $(CYAN)\_______________________$(RESET)"
	@echo "\n$(BLUE) ##### $(CYAN)DOCKERS $(BLUE)#####$(RESET)"
	@docker ps -a
	@echo "\n$(BLUE) ##### $(CYAN)IMAGES $(BLUE)#####$(RESET)"
	@docker image ls
	@echo "\n$(BLUE) ##### $(CYAN)VOLUMES $(BLUE)#####$(RESET)"
	@docker volume ls
	@echo "\n$(BLUE) ##### $(CYAN)NETWORKS $(BLUE)#####$(RESET)"
	@docker network ls
	@echo "\n$(BLUE) ##### $(CYAN)PROJECTS $(BLUE)#####$(RESET)"
	@if [ -z "$$(docker ps -a | tail -n +2)" ]; then \
		echo "$(WHITE1)PROJECT NAME $(RESET)"; \
	else \
		echo "$(WHITE1)PROJECT NAME\n$(WHITE1)$(PROJECT_NAME) $(RESET)"; \
	fi
	@echo "\n$(CYAN) _____________________________________________________________________\n$(RESET)"

logs:
	@docker-compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) logs

restart:
	@docker compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) restart

projects:
	@docker compose -p inception-fde-carv -f ./srcs/docker-compose.yml ps

.PHONY: all up down build clean re

# sudo mkdir -p /home/fde-carv/data/wordpress
# sudo chmod -R 777 /home/fde-carv/data/wordpress
# sudo chown -R root:root /home/fde-carv/data/wordpress
# sudo mkdir -p /home/fde-carv/data/mariadb
# sudo chmod -R 777 /home/fde-carv/data/mariadb
# sudo chown -R root:root /home/fde-carv/data/mariadb

# docker stop $(docker ps -aq)
# docker rm $(docker ps -aq)
# docker ps -a
# docker rmi $(docker images -q)
# docker images
# docker volume rm wordpress
# docker volume rm mariadb
# docker volume ls