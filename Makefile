# Makefile for Inception Project
# Defines targets to manage Docker containers using docker-compose.
# Author: ali-itawi
# These rules help in building, starting, stopping, cleaning, and viewing logs of the services.
# The make all command sets up necessary directories and starts the services, by using docker-compose build, we build the images before starting the containers.
# The make up command starts the services without rebuilding.
# The make clean command to stop the services.
# The make fclean command stops the services and removes data directories.
# The make prune to clean all docker volumes.

NAME := Inception
YML  := srcs/docker-compose.yml
USER := ali-itawi
DATA_DIR := /home/$(USER)/data

all: $(NAME)

$(NAME):
	mkdir -p $(DATA_DIR)/wordpress
	mkdir -p $(DATA_DIR)/mariadb
	docker-compose -f $(YML) up --build -d

up:
	docker-compose -f $(YML) up -d

clean:
	docker-compose -f $(YML) down

fclean: clean
	@sudo rm -rf $(DATA_DIR)/wordpress/*
	@sudo rm -rf $(DATA_DIR)/mariadb/*

prune :
	docker system prune --all --volumes

.PHONY: all up clean fclean prune