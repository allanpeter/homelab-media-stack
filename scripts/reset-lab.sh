#!/usr/bin/env sh
set -eu

if [ "${1:-}" != "--confirm" ]; then
  printf '%s\n' 'Uso: ./scripts/reset-lab.sh --confirm' >&2
  printf '%s\n' 'Remove containers, configurações e mídia deste laboratório.' >&2
  exit 2
fi

docker compose down --volumes --remove-orphans
rm -rf config media
printf '%s\n' 'Laboratório removido: config/ e media/ foram apagados.'
