# 4. Automação

Os serviços de automação já iniciam com `docker compose up -d`. Acesse-os pelo
dashboard em `http://localhost:8000` ou pelos endereços abaixo.

| Serviço | Endereço local |
|---|---|
| qBittorrent | `http://127.0.0.1:8080` |
| Prowlarr | `http://127.0.0.1:9696` |
| Sonarr | `http://127.0.0.1:8989` |
| Radarr | `http://127.0.0.1:7878` |

Todos os serviços que manipulam arquivos usam o mesmo caminho interno: `/data`.
Isso evita mapeamentos remotos inconsistentes entre cliente e organizadores.

## Credenciais do laboratório

Nada de senha temporária no log: a stack sobe pronta para uso.

| Serviço | Primeiro acesso | Como |
|---|---|---|
| qBittorrent | `admin` / `1234` | hash semeado em `defaults/qbittorrent.conf` |
| Sonarr | `admin` / `1234` | `defaults/arr-config.xml` |
| Radarr | `admin` / `1234` | `defaults/arr-config.xml` |
| Prowlarr | **abre direto, sem login** | `defaults/prowlarr-config.xml` |
| Jellyfin | assistente inicial | você define usuário e senha na 1ª tela |

Dois serviços fogem do padrão, e por motivos diferentes:

- **Prowlarr** guarda credenciais no banco e, diferente de Sonarr e Radarr, o
  `UserService` dele não escuta o evento de start que semeia usuário a partir do
  `config.xml` — não há arquivo que defina `admin`/`1234` ali. Como login não é
  obrigatório para você, ele sobe com `AuthenticationMethod=External`, que
  registra o mesmo `NoAuthenticationHandler` de `None`: nenhuma autenticação,
  sem tela de login e sem cadastro. Para exigir senha, troque por `Forms` e
  defina as credenciais na tela que ele apresentar.
- **Jellyfin** cria o usuário admin no assistente inicial, que já pede usuário e
  senha na primeira tela — semear exigiria escrever no banco antes de ele
  existir. Use `admin` / `1234` ali, ou deixe a senha em branco se preferir
  entrar sem digitar nada.

`1234` é uma senha fraca e está **versionada neste repositório**. Ela só é
aceitável enquanto `UI_BIND_ADDRESS` mantiver as UIs em `127.0.0.1` ou numa LAN
de confiança. Com `0.0.0.0`, qualquer máquina da rede entra no seu cliente de
downloads digitando `1234`.

Como a senha é fixa, o passo antigo de caçar a senha temporária no log virou
desnecessário — o qBittorrent só sorteia senha a cada boot quando nenhuma está
definida:

```bash
docker compose logs qbittorrent | grep -i password
```

### Se você já tinha um config/ de antes

As sementes só são copiadas quando o arquivo de destino **não existe** — uma
config sua nunca é sobrescrita. Para aplicá-las num lab já existente, apague os
arquivos correspondentes e suba de novo:

```bash
docker compose down
rm -f config/qbittorrent/qBittorrent/qBittorrent.conf
rm -f config/sonarr/config.xml config/radarr/config.xml config/prowlarr/config.xml
docker compose up -d
```

Atenção: em Sonarr e Radarr o usuário fica no banco, não no `config.xml`. Se o
banco já tiver um usuário, o seeding é ignorado e a senha antiga continua valendo
— use "esqueci a senha" do próprio app ou apague o `.db` se o lab for descartável.

### Dispensar o login de vez

Se preferir não digitar senha nenhuma no qBittorrent, descomente em
`defaults/qbittorrent.conf` (antes do primeiro `up`, ou edite o
`config/qbittorrent/qBittorrent/qBittorrent.conf` já gerado e reinicie):

```ini
WebUI\LocalHostAuth=false
WebUI\AuthSubnetWhitelistEnabled=true
WebUI\AuthSubnetWhitelist=192.168.0.0/24
```

`LocalHostAuth=false` libera quem acessa pelo próprio host; a faixa libera quem
vem da sua rede. Ajuste `AuthSubnetWhitelist` para a sua LAN real — uma faixa
ampla aqui equivale a deixar o cliente de downloads aberto para ela.

Nos Arr o equivalente é trocar, no `config.xml`, `AuthenticationMethod` para
`External` — isso remove o login inteiro, assumindo que algo na frente faz a
autenticação. É também a saída se você se trancar fora de Sonarr ou Radarr.

## qBittorrent respondendo apenas "Unauthorized"

Se a página do qBittorrent vier em branco com o texto `Unauthorized`, o container
está de pé — quem recusou a requisição foi a proteção CSRF dele, que compara o
header `Referer` com a própria origem. Um link vindo do dashboard (porta 8000)
para o qBittorrent (porta 8080) tem origens diferentes, então a checagem falha
antes mesmo da tela de login aparecer. Nenhum outro serviço da stack faz essa
validação, por isso só o qBittorrent quebra.

A stack já sobe com `WebUI\CSRFProtection=false` em `defaults/qbittorrent.conf`,
o que mantém os cards do dashboard funcionando num laboratório local. Se você
tinha um `config/qbittorrent/` de uma execução anterior, esse arquivo **não** é
sobrescrito — ajuste na mão e reinicie o serviço:

```bash
docker compose stop qbittorrent
# em config/qbittorrent/qBittorrent/qBittorrent.conf, na seção [Preferences]:
#   WebUI\CSRFProtection=false
docker compose start qbittorrent
```

Sem alterar nada também funciona: digite `http://<host>:8080` direto na barra de
endereços ou use um favorito, em vez de clicar no card. Sem `Referer`, a checagem
passa. Se for expor essa UI para fora do laboratório, volte a proteção para
`true` e aceite acessar por URL direta.

Configure apenas fontes e conteúdo que você tem autorização para usar.
