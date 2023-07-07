shell:
	docker exec -it feems sh

run:
	docker-compose stop feems
	docker-compose up -d
