SHELL=/bin/bash
.DEFAULT_GOAL := help
THIS_FILE := $(lastword $(MAKEFILE_LIST))

.PHONY: help
help:
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: run-dev
run-dev: ## Run dev
	@docker-compose up

.PHONY: ci
ci: ## Run ci
	@docker-compose -f docker-compose.yml up --abort-on-container-exit

.PHONY: build-prod
build-prod: ## Build production
	@docker-compose -f docker-compose.yml build app

.PHONY: push
push: ## Push production image
	@docker-compose -f docker-compose.yml push app


.PHONY: pull-and-run
pull-and-run: ## Pull production image and run
	@docker run -p 8080:8080 denis88dev/devops-for-programmers-project-74:latest npm run dev
