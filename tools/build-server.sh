#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
ROOT="$(pwd)"
export PATH="$ROOT/tools:/usr/bin:$PATH"
export NODE_ENV=development
yarn() { node "$ROOT/tools/yarn.cjs" "$@"; }
yarn build:server
echo "BUILD_OK"
