#!/usr/bin/env sh
set -eu

fail() {
  printf 'erro: %s\n' "$*" >&2
  exit 1
}

command -v docker >/dev/null 2>&1 || fail 'Docker não está instalado ou não está no PATH.'
docker compose version >/dev/null 2>&1 || fail 'O plugin Docker Compose não está disponível.'

if [ ! -f .env ]; then
  printf 'aviso: .env ainda não existe; execute make init antes de subir a stack.\n'
fi

if [ "$(docker info --format '{{.ServerVersion}}' 2>/dev/null || true)" = "" ]; then
  fail 'O daemon Docker não está acessível para este usuário.'
fi

printf 'ok: Docker e Docker Compose estão prontos.\n'
