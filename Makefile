.PHONY: help up down build logs restart migrate makemigrations shell django-shell superuser frontend-install frontend-dev frontend-build

# Docker Compose File
COMPOSE_FILE = docker-compose.yml
# Service Name in Docker Compose
WEB_SERVICE = web
# Frontend Directory
FRONTEND_DIR = frontend

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Docker Management
deploy: ## Deploy the project (build and start all services)
	@./scripts/deploy.sh

up: ## Start services in detached mode
	docker-compose -f $(COMPOSE_FILE) up -d

down: ## Stop and remove containers
	docker-compose -f $(COMPOSE_FILE) down

build: ## Build the Docker images
	docker-compose -f $(COMPOSE_FILE) build

logs: ## View logs from containers (follow mode)
	docker-compose -f $(COMPOSE_FILE) logs -f

restart: ## Restart services
	docker-compose -f $(COMPOSE_FILE) restart

# Backend (Django within Docker)
migrate: ## Run database migrations
	docker-compose -f $(COMPOSE_FILE) exec $(WEB_SERVICE) python manage.py migrate

makemigrations: ## Make migrations
	docker-compose -f $(COMPOSE_FILE) exec $(WEB_SERVICE) python manage.py makemigrations

shell: ## Open a bash shell inside the web container
	docker-compose -f $(COMPOSE_FILE) exec $(WEB_SERVICE) bash

django-shell: ## Open the Django shell inside the web container
	docker-compose -f $(COMPOSE_FILE) exec $(WEB_SERVICE) python manage.py shell

superuser: ## Create a superuser
	docker-compose -f $(COMPOSE_FILE) exec $(WEB_SERVICE) python manage.py createsuperuser

test: ## Run backend tests
	docker-compose -f $(COMPOSE_FILE) exec $(WEB_SERVICE) python manage.py test

# Frontend (Nuxt.js)
frontend-install: ## Install frontend dependencies
	cd $(FRONTEND_DIR) && npm install

frontend-dev: ## Run frontend in development mode
	cd $(FRONTEND_DIR) && npm run dev

frontend-build: ## Build frontend for production
	cd $(FRONTEND_DIR) && npm run build
