# Changelog

## 0.0.12-3

- Keep `curl` in the runtime image so `bashio` can read app configuration from
  the Home Assistant Supervisor API.
- Install the `cloudflared` companion shipped in the verified official OpenAI
  release archive.

## 0.0.12-2

- Added exact OpenAI Platform and Home Assistant paths for every configuration
  value.
- Added restricted runtime API-key creation instructions.
- Clarified which of the two HA-MCP URLs must be used.
- Expanded Russian and English field descriptions in the Home Assistant UI.

## 0.0.12-1

- Initial Home Assistant OS `amd64` release.
- Runs official OpenAI `tunnel-client` v0.0.12.
- Verifies the upstream Linux amd64 archive with SHA-256.
- Connects an OpenAI Secure MCP Tunnel to the HA-MCP Direct Access URL.
- Adds automatic startup, health watchdog, secret option masking, Russian and
  English configuration translations, and a local status UI on port 18080.
