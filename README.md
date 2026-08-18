# ARR Suite Demo

Laboratório Docker Compose, criado para aulas, com qBittorrent, Prowlarr,
Sonarr e Radarr. Ele é independente de Proxmox, NAS e da infraestrutura de quem
o executa.

## Escopo

Este repositório ensina a subir e integrar os serviços. Não inclui indexadores,
credenciais, conteúdo, configurações pessoais ou qualquer exposição pública.
Use somente fontes e conteúdo que você tenha autorização para acessar.

## Início rápido

```bash
cp .env.example .env
make doctor
make up
make ps
```

Consulte [Pré-requisitos](docs/01-pre-requisitos.md) e [Subir a
stack](docs/02-subir-stack.md) antes de configurar os serviços.

## Layout persistente

```text
config/                  # bancos e configurações dos serviços
media/
├── downloads/           # destino do cliente de download
├── movies/              # biblioteca do Radarr
└── tv/                  # biblioteca do Sonarr
```

Os três serviços que manipulam arquivos montam o mesmo caminho interno,
`/data`. Isso evita mapeamentos inconsistentes e permite operações atômicas
quando todas as pastas vivem no mesmo filesystem.

`config/`, `media/` e `.env` são locais e ignorados pelo Git.

## Segurança

- As UIs escutam apenas em `127.0.0.1` por padrão.
- Não publique a interface do qBittorrent na internet.
- Não versione tokens, credenciais, cookies nem o conteúdo de `config/`.
- Antes de uma aula, use `make reset` somente se aceitar apagar todo o estado
  local do laboratório.

## Limpeza

```bash
make down    # para, preserva config/ e media/
make reset   # para e apaga config/ e media/
```

## Próximas aulas

1. Configuração inicial do qBittorrent.
2. Integração Prowlarr → Sonarr/Radarr.
3. Caminhos, permissões e teste autorizado.
4. Diagnóstico e remoção do laboratório.
