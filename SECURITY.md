# Security policy

Please do not include API keys, HA-MCP Direct Access URLs, tunnel logs containing
private data, IP addresses, or Home Assistant configuration in public issues.

If a secret has been exposed, revoke or rotate it before reporting the problem.

This wrapper deliberately requests no privileged container capabilities, host
networking, Supervisor API, Home Assistant API, Docker API, or host filesystem
mounts.
