# OpenAI MCP Tunnel — configuration

## Required values

### Tunnel ID

Use the existing OpenAI Tunnel ID in the form `tunnel_...`. Keeping the same
ID means the ChatGPT plugin does not need to be recreated.

### Runtime API key

Use a dedicated OpenAI Platform runtime key restricted to:

- Tunnels: Read
- Tunnels: Use

Do not use an admin key. Rotate a key immediately if it appears in a screenshot,
chat message, log, or public issue.

### HA-MCP Direct Access URL

Copy the **Direct Access URL** from the HA-MCP server configuration. It is a
secret URL and must not be committed to Git or posted publicly.

### Startup wait timeout

The default is 120 seconds. It lets the tunnel wait for HA-MCP after Home
Assistant OS restarts.

## Migration from another host

1. Install and configure this app without starting it.
2. Stop the old `tunnel-client` process that uses the same Tunnel ID.
3. Start this app.
4. Open the app Web UI or `http://HOME_ASSISTANT_IP:18080/ui`.
5. Confirm `Health: live`, `Ready: ready`, and `Logs: connected`.
6. Test the existing ChatGPT plugin.
7. Enable Start on boot and Watchdog in Home Assistant.

Do not intentionally leave two clients polling with the same Tunnel ID.

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
  the existing ChatGPT plugin without changing the Tunnel ID.
