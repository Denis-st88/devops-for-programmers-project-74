SHELL=/bin/bash
.DEFAULT_GOAL := help
THIS_FILE := $(lastword $(MAKEFILE_LIST))

.PHONY: help
help:
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: prepare-env
prepare-env: ## Prepare .env
	@cp .env.example .env

.PHONY: build-prod
build-prod: ## Run production build
	@docker-compose -f docker-compose.yml build

.PHONY: test
test: ## Run tests
	@docker-compose -f docker-compose.yml up --abort-on-container-exit

.PHONY: dev
dev: ## Start project locally
	@$(MAKE) -f $(THIS_FILE) build-dev
	@$(MAKE) -f $(THIS_FILE) up-dev

.PHONY: build-dev
build-dev: ## Build dev
	@docker-compose -f docker-compose.yml -f docker-compose.override.yml build

.PHONY: up-dev
up-dev: ## Up dev
	@docker-compose -f docker-compose.yml -f docker-compose.override.yml up

.PHONY: push
push: ## Push image
	@$(MAKE) -f $(THIS_FILE) build-prod
	@$(MAKE) -f $(THIS_FILE) test
	@docker-compose -f docker-compose.yml push app
