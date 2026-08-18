# 1. Pré-requisitos

Este laboratório foi feito para uma máquina com Docker Engine e o plugin Docker
Compose. O primeiro episódio usa somente Jellyfin e arquivos de mídia que você
possui ou tem autorização para acessar.

## Preparar o diretório

```bash
git clone https://github.com/allanpeter/homelab-media-stack.git
cd homelab-media-stack
make doctor
make init
```

No Linux, descubra o usuário que deve ser dono dos arquivos e substitua `PUID` e
`PGID` no `.env`:

```bash
id -u
id -g
```

As interfaces web ficam expostas apenas em `127.0.0.1`. A série não abre portas
para a rede local ou para a internet por padrão.
