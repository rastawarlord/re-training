#!/usr/bin/env bash
# Install the root-requiring RE/pwn tools via MacPorts, then the user-level extras.
# Run this in a plain Terminal tab (not the Claude prompt): sudo needs a TTY for your password.
#
#   bash ~/Downloads/RE/scripts/install-re-tools.sh
#
# Nothing here deletes files. It only installs.

set -euo pipefail

PORT=/opt/local/bin/port
export PATH="/opt/local/bin:/opt/local/sbin:$HOME/.local/bin:$PATH"

if [ ! -x "$PORT" ]; then
  echo "MacPorts not found at $PORT. Install MacPorts first." >&2
  exit 1
fi

echo "==> Refreshing the MacPorts index (needs sudo)"
sudo "$PORT" selfupdate

# Root-requiring tools, all available as MacPorts ports
PORTS=(
  patchelf   # ELF patching (used with pwninit-style libc swaps)
  qemu       # user-mode emulation for foreign-arch binaries
  nasm       # assembler for shellcode work
  socat      # network service practice (nc-style) with a PTY
  rizin      # open-source RE framework (radare2 fork)
)

echo "==> Installing MacPorts packages: ${PORTS[*]}"
for p in "${PORTS[@]}"; do
  if "$PORT" installed "$p" 2>/dev/null | grep -q "(active)"; then
    echo "    $p already installed, skipping"
  else
    sudo "$PORT" install "$p"
  fi
done

# pwninit is not a MacPorts port. Build it from crates.io into ~/.cargo/bin
# (no sudo). Skipped if cargo is not available.
if command -v cargo >/dev/null 2>&1; then
  echo "==> Installing pwninit from crates.io (user-level, no sudo)"
  cargo install --locked pwninit
else
  echo "==> cargo not found; skipping pwninit"
fi

echo "==> Verifying"
for t in patchelf qemu-system-x86_64 nasm socat rizin pwninit; do
  printf "    %-12s " "$t"
  command -v "$t" || echo "MISSING"
done

# Note: MacPorts builds qemu system emulators only on macOS. qemu-x86_64 (user mode)
# needs a Linux host, so use dockerhost for foreign-architecture binaries.
echo "Done."
