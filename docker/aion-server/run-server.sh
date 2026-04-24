#!/usr/bin/env bash
set -euo pipefail

wait_for_endpoint() {
  local endpoint="$1"
  local host="${endpoint%:*}"
  local port="${endpoint##*:}"
  local deadline=$((SECONDS + AION_WAIT_TIMEOUT))

  if [[ -z "$host" || -z "$port" || "$host" == "$port" ]]; then
    echo "Invalid endpoint in AION_WAIT_FOR: $endpoint" >&2
    exit 1
  fi

  echo "Waiting for $host:$port..."
  until (: <>"/dev/tcp/${host}/${port}") >/dev/null 2>&1; do
    if (( SECONDS >= deadline )); then
      echo "Timed out waiting for $host:$port" >&2
      exit 1
    fi
    sleep 1
  done
}

AION_WAIT_TIMEOUT="${AION_WAIT_TIMEOUT:-120}"
IFS=',' read -r -a endpoints <<< "${AION_WAIT_FOR:-}"
for endpoint in "${endpoints[@]}"; do
  endpoint="${endpoint//[[:space:]]/}"
  if [[ -n "$endpoint" ]]; then
    wait_for_endpoint "$endpoint"
  fi
done

cd "${AION_SERVER_DIR:?AION_SERVER_DIR is required}"

start_script="./start.sh"
if grep -q $'\r' "$start_script"; then
  normalized_script="$(mktemp)"
  sed \
    -e 's/\r$//' \
    -e 's|^cd "\$(dirname "\$(readlink -f "\$0")")"$|cd "$AION_SERVER_DIR"|' \
    "$start_script" > "$normalized_script"
  chmod +x "$normalized_script"
  exec bash "$normalized_script" "$@"
fi

exec bash "$start_script" "$@"
