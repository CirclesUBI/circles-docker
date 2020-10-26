ENV ?= frontend

# Common docker-compose method and arguments
COMPOSE = docker-compose -f docker-compose.yml -f docker-compose.$(ENV).yml -p circles

# Tasks
build: ## Build containers
	$(COMPOSE) build

up: ## Start containers in background
	$(COMPOSE) up -d

down: ## Stop containers
	$(COMPOSE) down

logs: ## Follow container logs
	$(COMPOSE) logs -f --tail 100

contracts: ## Download and migrate contracts
	./scripts/migrate-contracts.sh

subgraph: ## Create and deploy subgraph
	./scripts/deploy-subgraph.sh

clean: ## Remove temporary files
	rm -rf .tmp

.PHONY: build up down logs subgraph contracts clean

.DEFAULT_GOAL := help

help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.PHONY: help
