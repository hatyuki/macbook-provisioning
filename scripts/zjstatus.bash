#!/usr/bin/env bash
set -euo pipefail

basedir="$(dirname "$(dirname "$(readlink -f "${0}")")")"
repository="dj95/zjstatus"

curl -Lso "${basedir}/.config/zellij/plugins/zjstatus.wasm" "https://github.com/${repository}/releases/download/$(curl -s https://ghlr.hatyuki.cloud/dj95/zjstatus)/zjstatus.wasm"
