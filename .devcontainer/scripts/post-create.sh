#!/usr/bin/env bash
set -euo pipefail

echo "[post-create] Installing Node dependencies"
npm install

if ! command -v act >/dev/null 2>&1; then
  echo "[post-create] Installing act"
  curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash -s -- -b /usr/local/bin

  if ! command -v act >/dev/null 2>&1 && [ -x "./bin/act" ]; then
    echo "[post-create] Linking workspace act binary into /usr/local/bin"
    sudo ln -sf "$PWD/bin/act" /usr/local/bin/act
  fi
else
  echo "[post-create] act already installed"
fi

echo "[post-create] Tool versions"
node --version
npm --version
docker --version
docker compose version
act --version
