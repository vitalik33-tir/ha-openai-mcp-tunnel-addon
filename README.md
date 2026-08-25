# OpenAI MCP Tunnel for Home Assistant OS

A Home Assistant app (formerly called an add-on) that keeps the official
OpenAI `tunnel-client` running next to a private Home Assistant MCP server.

It connects the HA-MCP **Direct Access URL** to an OpenAI Secure MCP Tunnel.
No inbound internet port, public MCP endpoint, privileged
container access, or host networking is required.

## Supported platform

- Home Assistant OS / Supervised
- `amd64` (`generic-x86-64`)
- OpenAI `tunnel-client` v0.0.12

## Installation

1. In Home Assistant open **Settings > Apps/Add-ons > App store**.
2. Open **Repositories** from the three-dot menu.
3. Add this repository URL:

   `https://github.com/vitalik33-tir/ha-openai-mcp-tunnel-addon`

4. Install **OpenAI MCP Tunnel**.
5. Configure a Tunnel ID, a runtime API key restricted to
   `Tunnels: Read + Use`, and the HA-MCP Direct Access URL.
6. Start the Home Assistant app.

The local status UI is available on port `18080` by default.

## Русская инструкция

1. Добавьте URL репозитория в магазине дополнений Home Assistant.
2. Установите **OpenAI MCP Tunnel**.
3. Введите `tunnel_id`, Runtime API-ключ с правами
   `Tunnels: Read + Use` и секретный **Direct Access URL** из HA-MCP.
4. Запустите дополнение и проверьте интерфейс состояния на порту `18080`.

Секреты не сохраняются в этом репозитории и не должны публиковаться в issues,
логах или снимках экрана.

### Где взять значения для настройки

| Поле | Источник |
| --- | --- |
| `ID туннеля` | [OpenAI Platform → Tunnels](https://platform.openai.com/settings/organization/tunnels): создать или выбрать туннель и скопировать его ID вида `tunnel_...`. |
| `Runtime API-ключ` | [OpenAI Platform → API keys](https://platform.openai.com/settings/organization/api-keys): создать ключ **Restricted**, разрешив только **Tunnels: Read + Use**. |
| `Direct Access URL HA-MCP` | Home Assistant → **Настройки → Устройства и службы → HA-MCP Custom Component → HA-MCP Server → Настроить**. Из двух URL выбрать именно **Direct Access URL**. |
| Ожидание запуска | Оставить `120` секунд. |
| Сетевой порт | Оставить `18080`. |

Чтобы увидеть **Direct Access URL**, откройте в Home Assistant:
**Настройки → Устройства и службы → HA-MCP Custom Component → HA-MCP Server →
Настроить**. Из двух показанных адресов скопируйте **Direct Access URL**, а не
**Webhook URL**. Этот адрес является секретом.

Подробная пошаговая инструкция находится в
[`openai_mcp_tunnel/DOCS.md`](openai_mcp_tunnel/DOCS.md).

## Security model

- Outbound HTTPS connection to OpenAI only.
- No Supervisor API, Home Assistant API, Docker API, host network, privileged
  mode, or host filesystem access.
- The downloaded OpenAI release archive is verified against its published
  SHA-256 before installation.
- The API key and Direct Access URL use password-type Home Assistant options.

This repository contains only the Home Assistant wrapper. The OpenAI binary is
downloaded from the official OpenAI GitHub release during the local build and
keeps its own license and notice files inside the image.

## References

- [OpenAI Secure MCP Tunnel](https://developers.openai.com/api/docs/guides/secure-mcp-tunnels)
- [Home Assistant app repositories](https://developers.home-assistant.io/docs/apps/repository/)

## License

The wrapper files in this repository are licensed under the MIT License. The
OpenAI `tunnel-client` binary is distributed under its own upstream terms.
