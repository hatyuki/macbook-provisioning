#!/usr/bin/env bash
set -ue

BASEDIR="$(dirname "$(dirname "$(readlink -f "${0}")")")"
BIN="${BINDIR:-${BASEDIR}/bin/mitamae}"
REPO="itamae-kitchen/mitamae"
RELEASE="${RELEASE:-latest}"

release() {
  release="${1}"

  if [[ "${release}" == "latest" ]]; then
    release="$(curl -s https://ghlr.hatyuki.cloud/${REPO})"
  fi
  echo -n "${release}"
}

arch() {
  case "$(uname -m | tr "[:upper:]" "[:lower:]")" in
  arm64)
    echo -n aarch64
    ;;
  esac
}

os() {
  os="$(uname -s | tr "[:upper:]" "[:lower:]")"
  echo -n "${os}"
}

curl -Lso "${BIN}" "https://github.com/${REPO}/releases/download/$(release "${RELEASE}")/mitamae-$(arch)-$(os)"
chmod +x "${BIN}"
