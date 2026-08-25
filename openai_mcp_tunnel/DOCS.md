# OpenAI MCP Tunnel — configuration

## Где взять значения

| Поле дополнения | Где взять | Что именно вставить |
| --- | --- | --- |
| **ID туннеля** | [OpenAI Platform → Tunnels](https://platform.openai.com/settings/organization/tunnels) | Создайте туннель или выберите нужный и скопируйте его ID вида `tunnel_...`. |
| **Runtime API-ключ** | [OpenAI Platform → API keys](https://platform.openai.com/settings/organization/api-keys) | Нажмите **Create new secret key**, выберите **Restricted** и разрешите только **Tunnels: Read** и **Tunnels: Use**. Все остальные разрешения оставьте `None`. Скопируйте ключ сразу — второй раз он не показывается. |
| **Direct Access URL HA-MCP** | Home Assistant → **Настройки → Устройства и службы → HA-MCP Custom Component → HA-MCP Server → Настроить** | На странице будут показаны два URL. Скопируйте именно URL, отмеченный **Direct Access URL**. Это секретный адрес, его нельзя публиковать. |
| **Ожидание HA-MCP** | Уже заполнено дополнением | Оставьте `120` секунд. |
| **Сетевой порт** | Уже заполнено дополнением | Оставьте `18080`. Это локальный интерфейс состояния. |

### Как правильно создать Runtime API-ключ

1. Откройте страницу [API keys](https://platform.openai.com/settings/organization/api-keys).
2. Нажмите **Create new secret key**.
3. В поле имени укажите, например, `home-assistant-mcp-tunnel`.
4. Для личной установки выберите владельца **You**.
5. В разделе **Permissions** выберите **Restricted**.
6. У пункта **Tunnels** включите только **Read** и **Use**.
7. Остальные разрешения оставьте `None`.
8. Создайте ключ, сразу скопируйте его в поле дополнения и сохраните настройки.

API-кредит для работы такого ключа не нужен: он используется для транспорта
туннеля, а не для вызова моделей. Не используйте Admin key или ключ с полными
правами.

> Если ключ попал в скриншот, чат, журнал или публичный issue, создайте новый,
> замените его в дополнении и удалите старый ключ на OpenAI Platform.

### Где увидеть Direct Access URL HA-MCP

1. В Home Assistant откройте **Настройки → Устройства и службы**.
2. Откройте интеграцию **HA-MCP Custom Component**.
3. Выберите **HA-MCP Server** и нажмите **Настроить**.
4. На экране подключения будут показаны два URL.
5. Скопируйте адрес, подписанный **Direct Access URL**, в одноимённое поле
   дополнения **OpenAI MCP Tunnel**. Не используйте **Webhook URL**.

Direct Access URL содержит секрет доступа. Не публикуйте его, не добавляйте в
Git и не показывайте в полном виде на снимках экрана.

## Required values

### Tunnel ID

Open [OpenAI Platform tunnel settings](https://platform.openai.com/settings/organization/tunnels),
create a tunnel or select the tunnel you want to use, and copy its ID in the
form `tunnel_...`.

### Runtime API key

Use a dedicated OpenAI Platform runtime key restricted to:

- Tunnels: Read
- Tunnels: Use

Do not use an admin key. Rotate a key immediately if it appears in a screenshot,
chat message, log, or public issue.

Create it at [OpenAI Platform API keys](https://platform.openai.com/settings/organization/api-keys):
select **Restricted**, permit only **Tunnels: Read + Use**, and leave every other
permission as `None`.

### HA-MCP Direct Access URL

Copy the **Direct Access URL** from the HA-MCP server configuration. It is a
secret URL and must not be committed to Git or posted publicly.

Path in Home Assistant: **Settings → Devices & services → HA-MCP Custom
Component → HA-MCP Server → Configure**. The dialog shows two URLs; use the one
explicitly labeled **Direct Access URL**.

### Startup wait timeout

The default is 120 seconds. It lets the tunnel wait for HA-MCP after Home
Assistant OS restarts.

## Start and verify

1. Save the app configuration.
2. Start the app.
3. Open the app Web UI or `http://HOME_ASSISTANT_IP:18080/ui`.
4. Confirm `Health: live`, `Ready: ready`, and `Logs: connected`.
5. Connect or refresh the app in ChatGPT and test an HA-MCP read operation.
6. Enable Start on boot and Watchdog in Home Assistant.

## Network requirements

The app needs:

- outbound HTTPS to `api.openai.com:443`;
- access to the configured private HA-MCP URL;
- no inbound internet access.

Port `18080` is the local diagnostic UI. Do not forward it on the router.

## Troubleshooting

- **The app cannot be built:** verify that HAOS can download files from GitHub.
- **Profile creation failed:** recheck the Tunnel ID and Direct Access URL.
- **Health is live but Ready is not ready:** verify the API key permissions and
  HA-MCP URL, then check the app logs.
- **ChatGPT still fails:** confirm `Logs: connected`, then reconnect or refresh
  the ChatGPT app and verify that it uses the configured Tunnel ID.
