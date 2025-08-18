#!/usr/bin/env bash
set -euo pipefail

# --- Állítható értékek ---
BIN="${BIN:-/root/work/rsvpn/build/rsvnd}"          # fork bináris elérési útja
DATA="${DATA:-/root/work/rsvpn/data}"        # adatkönyvtár
P2P="${P2P:-31001}"                   # új P2P port (tcp+udp)
HTTP="${HTTP:-31002}"                 # új HTTP API port
RPC="${RPC:-31003}"                   # új RPC port
EXTRA1="${EXTRA1:-31004}"             # extra/WS
EXTRA2="${EXTRA2:-31005}"
SEEDS="${SEEDS:-10.0.0.2:31001}"    # seed node(oka)t belső IP:PORT formában
LOG="${LOG:-/var/log/rsvpn.log}"

# --- Előkészítés ---
mkdir -p "$DATA"
touch "$LOG"

# --- Indítás (systemd nélkül foreground) ---
exec "$BIN" \
  --chaindir "$DATA" \
  --p2pport "$P2P" \
  --httpport "$HTTP" \
  --rpcport "$RPC" \
  --wsport "$EXTRA1" \
  --wssport "$EXTRA2" \
  --seednodes "$SEEDS" \
  >> "$LOG" 2>&1
