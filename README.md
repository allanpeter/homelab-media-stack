# Homelab Media Stack

Biblioteca de mídia pessoal com Jellyfin, qBittorrent, Prowlarr, Sonarr e Radarr
em Docker Compose. Funciona em qualquer host Docker; não depende de Proxmox, NAS
ou da infraestrutura usada para gravar a série.

> Série no YouTube: **link será adicionado antes da publicação**.

Em poucos minutos você terá uma biblioteca local com mídia própria ou autorizada
pronta para reproduzir e os serviços de organização disponíveis no mesmo painel.

## Comece aqui

```bash
git clone <URL_DO_REPOSITORIO>
cd homelab-media-stack
docker compose up -d
```

Abra `http://localhost:8000`. O painel mostra os links para todos os serviços.
O acesso pelo localhost e pela rede local já vem habilitado, sem criar `.env`.
Se abrir o painel por um IP da rede, como `http://192.168.1.50:8000`, os links
usarão automaticamente esse mesmo IP. Consulte [Pré-requisitos](docs/01-pre-requisitos.md)
e [Subir a stack](docs/02-subir-stack.md).

## Série por episódio

| Episódio | Resultado | Material |
|---|---|---|
| 0 — Biblioteca pessoal | Jellyfin reproduzindo uma biblioteca local | [Guia](docs/03-biblioteca-jellyfin.md) · vídeo em breve |
| 1 — Arquivos e permissões | Layout `/data` consistente e persistente | guia em breve |
| 2 — Automação | qBittorrent, Prowlarr, Sonarr e Radarr | [Guia](docs/04-automacao-opcional.md) · vídeo em breve |
| 3 — Operação e limpeza | Diagnóstico, atualização e remoção segura | guia em breve |

## Hardware e infraestrutura

Uso e recomendo equipamentos documentados na **SetupZone**. O link e uma
eventual identificação de afiliação serão adicionados antes da publicação; não
há recomendação comercial oculta neste repositório.

## Arquitetura

```text
Dashboard :8000
├── Jellyfin :8096
├── qBittorrent :8080
├── Prowlarr :9696
├── Sonarr :8989
└── Radarr :7878

Jellyfin
└── /data:ro
    ├── movies/
    └── tv/

Automação
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

`config/`, `media/` e `.env` são locais e ignorados pelo Git. O `.env` é
opcional: o Compose possui valores padrão e inicia sem configuração manual.
As portas dos aplicativos podem ser alteradas pelas variáveis `*_PORT` do
`.env.example`. O dashboard usa essas mesmas variáveis para gerar os links.
Sem `.env`, os fallbacks do Compose usam os valores documentados no exemplo.

## Comandos

| Comando | Serviços |
|---|---|
| `docker compose up -d` | Todos os serviços e o dashboard |
| `docker compose down` | Para a stack e preserva o estado |
| `docker compose ps` | Mostra o estado dos serviços |
| `docker compose logs -f --tail=100` | Acompanha os logs |

Não é necessário Makefile nem executar uma inicialização separada. O serviço
`init` do Compose prepara as pastas e permissões automaticamente antes dos demais
serviços. No primeiro acesso, configure os usuários, bibliotecas e integrações
entre os aplicativos conforme os guias; subir os containers não configura essas
integrações automaticamente.

## Segurança e escopo

- As UIs escutam em `0.0.0.0` por padrão, permitindo acesso pela rede local.
  Restrinja essas portas no firewall. Para limitar ao host, defina
  `UI_BIND_ADDRESS=127.0.0.1` no `.env`.
- Não publique qBittorrent, Jellyfin ou as APIs Arr diretamente na internet.
- Não versione tokens, credenciais, cookies nem o conteúdo de `config/`.
- Use somente mídia e fontes que você possui ou tem autorização para acessar.
- Para apagar todo o estado local do laboratório, existe o script opcional
  `./scripts/reset-lab.sh --confirm`. Ele remove `config/` e `media/`, incluindo
  os arquivos de mídia.
