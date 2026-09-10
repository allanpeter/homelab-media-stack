# 1. Pré-requisitos

Você precisa de Docker Engine com o plugin Docker Compose ou Docker Desktop,
com o Docker em execução. A stack inclui Jellyfin, qBittorrent, Prowlarr, Sonarr,
Radarr e um dashboard com links para todos os serviços.

## Preparar o diretório

```bash
git clone https://github.com/allanpeter/homelab-media-stack.git
cd homelab-media-stack
docker compose up -d
```

Abra `http://localhost:8000`. As pastas e permissões
são preparadas automaticamente pelo Compose; não há etapa de inicialização
manual.

## Configuração opcional

O `.env` é opcional. Os valores padrão são `PUID=1000`, `PGID=1000` e
`TZ=America/Sao_Paulo`. No Linux, caso precise usar outro usuário como dono dos
arquivos, consulte seus IDs:

```bash
id -u
id -g
```

Copie `.env.example` para `.env` e ajuste `PUID` e `PGID` antes de subir a stack.
Em macOS, mantenha os valores padrão.

As portas 8000, 8096, 8080, 9696, 8989 e 7878 precisam estar livres. As interfaces
ficam disponíveis no localhost e na rede local por padrão (`UI_BIND_ADDRESS=0.0.0.0`).
Você pode acessar `http://IP_DO_HOST:8000` sem criar `.env`. Para restringir
ao host, defina `UI_BIND_ADDRESS=127.0.0.1` no `.env`. As portas dos aplicativos também
podem ser personalizadas pelas variáveis `*_PORT` do `.env.example`.

Para um diagnóstico opcional do Docker, execute `./scripts/doctor.sh`.
