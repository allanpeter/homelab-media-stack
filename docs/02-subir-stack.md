# 2. Subir a stack

```bash
make up
make ps
```

Interfaces locais:

| Serviço | Endereço |
|---|---|
| qBittorrent | `http://127.0.0.1:8080` |
| Prowlarr | `http://127.0.0.1:9696` |
| Sonarr | `http://127.0.0.1:8989` |
| Radarr | `http://127.0.0.1:7878` |

O qBittorrent gera uma senha temporária do usuário `admin` no primeiro boot.
Recupere-a com:

```bash
docker compose logs qbittorrent | grep -i password
```

Altere a senha logo no primeiro acesso.
