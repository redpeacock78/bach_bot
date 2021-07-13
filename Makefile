name =

.PHONY: up
up: ## Start the container
	@docker-compose up -d
.PHONY: build-up
build-up: ## Build the container and get started
	@docker-compose up -d --build
.PHONY: stop
stop: ## Stop running containers without deleting them
	@docker-compose stop
.PHONY: sown
down: ## Stop the container and delete the container, network, volume, and image created in up
	@docker-compose down
.PHONY: down-rm
down-rm: ## Stop the container and delete the container, network, volume, and image created in up (including the named volume)
	@docker-compose down --volume
.PHONY: log
log: ## View the log (ARGS: name)
	@docker-compose logs ${name}

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
