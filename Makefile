# Internal variables
# ====================================
pull = pull
build = build
skip = skip
unset = 0

# Basic docker-compose variables
# ====================================
base_file = -f docker-compose.yml
namespace = circles
# ====================================

# User variables
# ====================================
# PostgreSQL username for psql command
POSTGRES_USER ?= postgres

# Arguments to set if api or relayer are built from local folder ("build"),
# pulled from registry ("pull") or skipped ("skip")
RELAYER ?= $(pull)
API ?= $(pull)

# Flag to set if database and redis ports can be used outside of docker network
EXPOSE_PORTS ?= $(unset)
# ====================================

# Use user arguments to build docker-compose base command
ifneq ($(unset), $(EXPOSE_PORTS))
	EXPOSE_PORTS_FILE = -f docker-compose.expose-ports.yml
endif

ifeq ($(pull), $(RELAYER))
	RELAYER_FILE = -f docker-compose.relayer-pull.yml
endif

ifeq ($(build), $(RELAYER))
	RELAYER_FILE = -f docker-compose.relayer-pull.yml -f docker-compose.relayer-build.yml
endif

ifeq ($(pull), $(API))
	API_FILE = -f docker-compose.api-pull.yml
endif

ifeq ($(build), $(API))
	API_FILE = -f docker-compose.api-pull.yml -f docker-compose.api-build.yml
endif
PATHFINDER_FILE= -f docker-compose.pathfinder-pull.yml

COMPOSE_CMD := docker compose

COMPOSE_UP = ${COMPOSE_CMD} ${base_file} ${RELAYER_FILE} ${API_FILE} ${EXPOSE_PORTS_FILE}  -p ${namespace}

# Address all containers even when they are not used. This is useful as a
# independent "catch all" regardless of which containers were started
COMPOSE_ALL = ${COMPOSE_CMD} ${base_file} -f docker-compose.relayer-${pull}.yml -f docker-compose.api-${pull}.yml -f docker-compose.pathfinder-pull.yml -p ${namespace}

# Tasks
up: ## Start containers in background
	$(COMPOSE_UP) up --detach --remove-orphans --build

down: ## Stop containers and remove attached volumes
	$(COMPOSE_ALL) down --remove-orphans --volumes

logs: ## Follow container logs
	$(COMPOSE_ALL) logs --follow --tail 100

contracts: ## Download and migrate contracts
	./scripts/migrate-contracts.sh; ./scripts/update_contract_addresses.sh

data: ## Insert Data in news tables
	./scripts/insert-news.sh

pathfinder:
	${COMPOSE_CMD} ${PATHFINDER_FILE} -p ${namespace} up --detach --build

clean: ## Remove temporary files
	rm -rf .tmp

sh: ## Run shell in a container
	docker exec -it $(c) /bin/sh

psql: ## Run psql in circles-db container
	docker exec -it circles-db psql -U $(POSTGRES_USER)

.PHONY: up down logs contracts clean sh psql

.DEFAULT_GOAL := help

help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.PHONY: help
