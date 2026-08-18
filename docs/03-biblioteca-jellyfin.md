# 3. Biblioteca Jellyfin

O layout é intencional:

```text
media/
├── movies/
├── tv/
└── downloads/  # usado apenas pelo módulo de automação opcional
```

Coloque uma amostra de mídia própria ou autorizada em `media/movies` ou
`media/tv` e use **Scan All Libraries** no Jellyfin. A primeira vitória desta
série é ver uma biblioteca funcionando e reproduzir o conteúdo em um cliente
Jellyfin.

Não habilite descoberta DLNA, exposição por proxy ou portas públicas neste
laboratório. O Compose foi desenhado para uso local.
