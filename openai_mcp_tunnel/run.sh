#!/usr/bin/with-contenv bashio
set -euo pipefail

tunnel_id="$(bashio::config 'tunnel_id')"
api_key="$(bashio::config 'api_key')"
mcp_server_url="$(bashio::config 'mcp_server_url')"
organization_id="$(bashio::config 'organization_id')"
allow_remote_ui="$(bashio::config 'allow_remote_ui')"
startup_wait_timeout="$(bashio::config 'startup_wait_timeout')"

if [[ -z "${tunnel_id}" || -z "${api_key}" || -z "${mcp_server_url}" ]]; then
    bashio::log.fatal "Fill in tunnel_id, api_key, and mcp_server_url in the app configuration."
    exit 1
fi

export CONTROL_PLANE_API_KEY="${api_key}"
if [[ -n "${organization_id}" ]]; then
    export CONTROL_PLANE_ORGANIZATION_ID="${organization_id}"
fi
export MCP_STARTUP_WAIT_TIMEOUT="${startup_wait_timeout}s"
export HOME="/tmp/tunnel-client-home"
export XDG_CONFIG_HOME="${HOME}/.config"

work_dir="${HOME}"
rm -rf -- "${work_dir}"
mkdir -p -- "${work_dir}"

bashio::log.info "Preparing tunnel-client profile for ${tunnel_id}"
if ! /usr/local/bin/tunnel-client init \
    --sample sample_mcp_remote_no_auth \
    --profile home-assistant \
    --tunnel-id "${tunnel_id}" \
    --mcp-server-url "${mcp_server_url}" \
    >/dev/null 2>&1; then
    bashio::log.fatal "Could not create the tunnel-client profile. Check the Tunnel ID and Direct Access URL."
    exit 1
fi

unset api_key mcp_server_url organization_id

bashio::log.info "Starting OpenAI Secure MCP Tunnel"
bashio::log.info "Status UI: http://<HOME_ASSISTANT_IP>:18080/ui"

run_args=(
    --profile home-assistant
    --health.listen-addr 0.0.0.0:8080
)

if bashio::var.true "${allow_remote_ui}"; then
    run_args+=(--allow-remote-ui)
fi

exec /usr/local/bin/tunnel-client run "${run_args[@]}"
