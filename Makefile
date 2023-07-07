run:
	docker-compose stop feems
	docker-compose up -d
	docker exec -it feems /bin/bash -c ". /opt/conda/etc/profile.d/conda.sh && conda activate feems_env && /bin/bash"
