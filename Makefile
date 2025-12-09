all: create build up

create:
	mkdir -p /home/pgiroux/data /home/pgiroux/data/wordpress /home/pgiroux/data/mariadb;\
	chmod -R 777 /home/pgiroux/data/

build:
	docker compose -f docker-compose.yml build

up:
	docker compose -f docker-compose.yml up -d

down:
	docker compose -f docker-compose.yml down

re: clean create build up

clean: down
	docker image ls | grep wordpress | awk '{print $1}' | xargs -r docker rmi -f;\
	docker image ls | grep mariadb | awk '{print $1}' | xargs -r docker rmi -f;\
	docker image ls | grep nginx | awk '{print $1}' | xargs -r docker rmi -f;\
	docker volume ls | grep mariadb | awk '{print $2}' | xargs -r docker volume rm ;\
	docker volume ls | grep wordpress | awk '{print $2}' | xargs -r docker volume rm ;\
	rm -rf /home/pgiroux/data/;\
	rm -rf /home/pgiroux/data/wordpress;\
	rm -rf /home/pgiroux/data/mariadb;\

.PHONY: all re down clean up build create
