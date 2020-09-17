DC=docker-compose
DC_UP=$(DC) up -d
PROJECT_NAME=whoami
ENV=dev

down: ## Down containers
	$(DC) down --remove-orphans

help: ## Show commands
	@grep -E '(^[0-9a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-25s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'


network: ## Create Network
	docker network create ${PROJECT_NAME}

install: update ## Install, prepare and build project

update: ## Update project
	# git pull
	$(DC) down --remove-orphans
	$(DC) pull
	$(DC) build
	$(MAKE) start

start: ## Up containers
	$(DC_UP)

stop: ## Stop project
	$(DC) stop

logs: ## Show logs
	# Follow the logs.
	$(DC) logs -f

reset: ## Reset all (use it with precaution!)
	make uninstall
	make install

uninstall:
	make stop
	# Kill containers.
	$(DC) kill
	# Remove containers.
	$(DC) down --volumes --remove-orphans
#	./scripts/linux/uninstall.sh


.DEFAULT_GOAL := help

.PHONY: help
