#!/usr/bin/env sh
set -e

# Start vault in background
vault server -dev -dev-root-token-id=root -dev-listen-address=0.0.0.0:8200 &
VAULT_PID=$!

sleep 2

export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN="root"

vault secrets enable -path=secret kv-v2 2>/dev/null || true
vault kv put secret/jwt HS256_SECRET="${JWT_SHARED_SECRET}"

wait $VAULT_PID