# 2. Subir a stack

```bash
docker compose up -d
docker compose ps
```

O Compose cria as pastas locais, ajusta as permissões e sobe todos os serviços.
Abra o painel:

`http://localhost:8000`

O acesso pela rede local já está habilitado por padrão. Se o host recebeu o IP `192.168.1.50`, também é possível abrir
`http://192.168.1.50:8000`. O painel monta os links usando o mesmo host pelo
qual foi acessado, sem editar IP em arquivo algum.

No wizard inicial, crie um usuário administrador e adicione as bibliotecas:

- filmes: `/data/movies`;
- séries: `/data/tv`.

O Jellyfin recebe `/data` como somente leitura. A gestão dos arquivos acontece
no host, nunca pela interface do servidor de mídia.
