ENV ?= development

# Common docker-compose method and arguments
COMPOSE = docker-compose -f docker-compose.yml -f docker-compose.$(ENV).yml -p circles

# Tasks
build: ## Build containers
	$(COMPOSE) build

up: ## Start containers in background
	$(COMPOSE) up -d

down: ## Stop containers
	$(COMPOSE) down

logs: ## Show container logs
	$(COMPOSE) logs -f

migrate: ## Download and migrate contracts
	./scripts/migrate-contracts.sh

.PHONY: build up down logs migrate

.DEFAULT_GOAL := help

help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.PHONY: help
