# Homelab Media Stack

Biblioteca de mídia pessoal com Jellyfin e automação opcional em Docker Compose.
Funciona em qualquer host Docker; não depende de Proxmox, NAS ou da infraestrutura
usada para gravar a série.

> Série no YouTube: **link será adicionado antes da publicação**.

Comece pelo Jellyfin: em poucos minutos você terá uma biblioteca local com mídia
própria ou autorizada pronta para reproduzir. A automação vem depois, como um
módulo separado.

## Comece aqui

```bash
cp .env.example .env
make doctor
make up
make ps
```

Abra `http://127.0.0.1:8096` e conclua o wizard do Jellyfin. Consulte
[Pré-requisitos](docs/01-pre-requisitos.md) e [Subir a
biblioteca](docs/02-subir-stack.md).

## Série por episódio

| Episódio | Resultado | Material |
|---|---|---|
| 0 — Biblioteca pessoal | Jellyfin reproduzindo uma biblioteca local | [Guia](docs/03-biblioteca-jellyfin.md) · vídeo em breve |
| 1 — Arquivos e permissões | Layout `/data` consistente e persistente | guia em breve |
| 2 — Automação opcional | qBittorrent, Prowlarr, Sonarr e Radarr | [Guia](docs/04-automacao-opcional.md) · vídeo em breve |
| 3 — Operação e limpeza | Diagnóstico, atualização e remoção segura | guia em breve |

## Hardware e infraestrutura

Uso e recomendo equipamentos documentados na **SetupZone**. O link e uma
eventual identificação de afiliação serão adicionados antes da publicação; não
há recomendação comercial oculta neste repositório.

## Arquitetura

```text
Jellyfin (padrão)
└── /data:ro
    ├── movies/
    └── tv/

Automação opcional (profile: automation)
├── qBittorrent ── /data/downloads
├── Sonarr      ── /data/tv
├── Radarr      ── /data/movies
└── Prowlarr    ── integrações por API
```

```text
config/                  # bancos e configurações dos serviços
media/
├── downloads/           # somente automação opcional
├── movies/              # biblioteca de filmes
└── tv/                  # biblioteca de séries
```

Os serviços que manipulam arquivos usam o mesmo caminho interno, `/data`. Isso
evita mapeamentos inconsistentes e permite operações atômicas quando todas as
pastas vivem no mesmo filesystem.

`config/`, `media/` e `.env` são locais e ignorados pelo Git.

## Perfis Docker Compose

| Comando | Serviços |
|---|---|
| `make up` | Jellyfin |
| `make up-automation` | Jellyfin + qBittorrent + Prowlarr + Sonarr + Radarr |
| `make down` | Para a stack e preserva o estado |
| `make reset` | Para a stack e apaga `config/` e `media/` |

## Segurança e escopo

- As UIs escutam apenas em `127.0.0.1` por padrão.
- Não publique qBittorrent, Jellyfin ou as APIs Arr diretamente na internet.
- Não versione tokens, credenciais, cookies nem o conteúdo de `config/`.
- Use somente mídia e fontes que você possui ou tem autorização para acessar.
- Antes de uma aula, use `make reset` somente se aceitar apagar todo o estado
  local do laboratório.
