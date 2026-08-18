# 4. Automação opcional

Depois de validar a biblioteca, suba os serviços de automação:

```bash
make up-automation
```

| Serviço | Endereço local |
|---|---|
| qBittorrent | `http://127.0.0.1:8080` |
| Prowlarr | `http://127.0.0.1:9696` |
| Sonarr | `http://127.0.0.1:8989` |
| Radarr | `http://127.0.0.1:7878` |

Todos os serviços que manipulam arquivos usam o mesmo caminho interno: `/data`.
Isso evita mapeamentos remotos inconsistentes entre cliente e organizadores.

O qBittorrent gera uma senha temporária para `admin` no primeiro boot. Consulte
o log, altere-a no primeiro acesso e nunca exponha essa interface publicamente:

```bash
docker compose logs qbittorrent | grep -i password
```

Configure apenas fontes e conteúdo que você tem autorização para usar.
