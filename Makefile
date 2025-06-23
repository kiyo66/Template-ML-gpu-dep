.PHONY: up del exec

up:
	@echo "Creating .env file."
	@./env/scripts/create_env.sh
	@echo "Creating and starting the container."
	@docker compose -f ./docker/docker-compose.yml up -d --build
	@echo "Finished."

del:
	@docker stop template-ml-with-gpu
	@docker rm template-ml-with-gpu
	@docker rmi template_ml_with_gpu:latest
	@echo "Finished."

exec:
	@docker exec -it  template_ml_with_gpu /usr/bin/fish

