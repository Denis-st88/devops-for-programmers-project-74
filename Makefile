SHELL=/bin/bash
.DEFAULT_GOAL := help
THIS_FILE := $(lastword $(MAKEFILE_LIST))

.PHONY: help
help:
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


# Prod

.PHONY: build-prod
build-prod: ## Run production build
	@docker-compose -f docker-compose.yml build

.PHONY: ci
ci: ## Run tests
	@docker-compose -f docker-compose.yml up --abort-on-container-exit

.PHONY: test-prod
test-prod: ## Run production test
	@$(MAKE) -f $(THIS_FILE) build-prod
	@$(MAKE) -f $(THIS_FILE) ci

.PHONY: push-prod
push-prod: ## Push production image
	@docker-compose -f docker-compose.yml push app



# Dev

.PHONY: build-dev
build-dev: ## Build dev
	@docker-compose -f docker-compose.yml -f docker-compose.override.yml build

.PHONY: up-dev
up-dev: ## Up dev
	@docker-compose -f docker-compose.yml -f docker-compose.override.yml up

.PHONY: start-dev
start-dev: ## Start dev build
	@$(MAKE) -f $(THIS_FILE) build-dev
	@$(MAKE) -f $(THIS_FILE) up-dev
