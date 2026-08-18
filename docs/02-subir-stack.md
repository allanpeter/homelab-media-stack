# 2. Subir a biblioteca

```bash
make up
make ps
```

O comando sobe somente o Jellyfin, núcleo da biblioteca:

| Serviço | Endereço |
|---|---|
| Jellyfin | `http://127.0.0.1:8096` |

No wizard inicial, crie um usuário administrador e adicione as bibliotecas:

- filmes: `/data/movies`;
- séries: `/data/tv`.

O Jellyfin recebe `/data` como somente leitura. A gestão dos arquivos acontece
no host, nunca pela interface do servidor de mídia.

Para subir também a automação opcional das aulas posteriores:

```bash
make up-automation
```

Consulte [Biblioteca Jellyfin](03-biblioteca-jellyfin.md) antes de avançar para
a automação.
