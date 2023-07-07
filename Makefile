run:
	docker-compose stop feems
	docker-compose up -d
	docker exec -it feems /bin/bash
