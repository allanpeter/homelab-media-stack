# 1. Pré-requisitos

Este laboratório foi feito para uma máquina com Docker Engine e o plugin Docker
Compose. O conteúdo de demonstração deve ser obtido somente de fontes que você
tenha autorização para usar.

## Preparar o diretório

```bash
git clone <URL_DO_REPOSITORIO> arr-suite-demo
cd arr-suite-demo
make doctor
make init
```

No Linux, descubra o usuário que deve ser dono dos arquivos e substitua `PUID` e
`PGID` no `.env`:

```bash
id -u
id -g
```

As interfaces web ficam expostas apenas em `127.0.0.1`. A primeira aula não
abre portas para a rede local ou para a internet.
