SHELL=/bin/bash
.DEFAULT_GOAL := help
THIS_FILE := $(lastword $(MAKEFILE_LIST))

.PHONY: help
help:
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: build-prod
build-prod: ## Build docker-compose.yml app
	@docker-compose -f docker-compose.yml build app

.PHONY: test-prod
test-prod: ## Run tests. Build: Dockerfile.production
	@docker-compose -f docker-compose.yml up --abort-on-container-exit

.PHONY: push-prod
push-prod: ## Build and push app prod image
	@$(MAKE) -f $(THIS_FILE) test-prod
	@$(MAKE) -f $(THIS_FILE) build-prod
	@docker-compose -f docker-compose.yml push app
