help:
	@echo "Available commands:"
	@echo "  make deploy - Deploy DataSHIELD and start the docker images"
	@echo "  make pull - Pull the latest images"
	@echo "  make up - Start the docker images"
	@echo "  make create_accounts - Create accounts listed in the .csv accounts file"
	@echo "  make update_accounts - Update the .csv accounts files writing the full list of the accounts"
	@echo "  make stop - Stop the server"
	@echo "  make logs - Tail logs"

deploy:
	@echo "Deploy of DataSHIELD..."
	bash src/setup.sh

pull:
	@echo "Pulling the latest images..."
	docker compose --env-file MDR_RA.env pull

up:
	@echo "Starting the server..."
	docker compose --env-file MDR_RA.env up -d


stop:
	@echo "Stopping the server..."
	docker compose --env-file MDR_RA.env down

logs:
	@echo "Showing logs..."
	docker compose logs -f

