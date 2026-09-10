SHELL := /bin/sh

.DEFAULT_GOAL := help

.PHONY: help init doctor up down logs ps config reset

help:
	@printf '%s\n' 'Targets: init doctor up down logs ps config reset'

init:
	docker compose run --rm init

doctor:
	@./scripts/doctor.sh

up:
	docker compose up -d
	@printf '%s\n' 'Painel: http://localhost:8000'

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
