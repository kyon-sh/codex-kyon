#!/bin/bash
# Kyon notification utility using OSC escape sequences.
# Usage: kyon-notify.sh <title> <body>
#
# For structured Kyon notifications, title should be "kyon://cli-agent"
# and body should be a JSON string matching the cli-agent notification schema.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/should-use-structured.sh"

# Only emit notifications when we've confirmed the Kyon build can render them.
if ! should_use_structured; then
    exit 0
fi

TITLE="${1:-Notification}"
BODY="${2:-}"

# OSC 777 format: \033]777;notify;<title>;<body>\007
SEQ=$(printf '\033]777;notify;%s;%s\007' "$TITLE" "$BODY")

# Inside tmux, a raw OSC is consumed by tmux and never reaches the outer
# terminal (Kyon). Wrap it in tmux's passthrough DCS so tmux forwards it:
# ESC P tmux ; <seq with every ESC doubled> ESC \. Requires the tmux server to
# have `allow-passthrough on` (the Kyon session shim sets this) -- this is what
# lets the cli-agent notification survive a tmux-wrapped SSH session.
if [ -n "${TMUX:-}" ]; then
    SEQ="${SEQ//$'\x1b'/$'\x1b\x1b'}"
    SEQ=$'\x1bPtmux;'"$SEQ"$'\x1b\\'
fi

# Write directly to /dev/tty to ensure it reaches the terminal.
printf '%s' "$SEQ" > /dev/tty 2>/dev/null || true
