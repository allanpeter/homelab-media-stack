SHELL := /bin/sh

.DEFAULT_GOAL := help

.PHONY: help init doctor up up-library up-automation down logs ps config reset

help:
	@printf '%s\n' 'Targets: init doctor up up-library up-automation down logs ps config reset'

init:
	@test -f .env || cp .env.example .env
	@mkdir -p config/qbittorrent config/prowlarr config/sonarr config/radarr \
		media/downloads media/movies media/tv

doctor:
	@./scripts/doctor.sh

up: up-library

up-library: init
	docker compose up -d

up-automation: init
	docker compose --profile automation up -d

down:
	docker compose down

logs:
	docker compose logs -f --tail=100

ps:
	docker compose ps

config:
	docker compose config

reset:
	@./scripts/reset-lab.sh --confirm
