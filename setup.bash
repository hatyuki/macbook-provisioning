#!/usr/bin/env bash
set -eu

# macOS の場合、Command Line Tools をチェックしてインストール
if [[ "$(uname -s)" == "Darwin" ]]; then
  if ! xcode-select -p &> /dev/null; then
    echo "Installing macOS Command Line Tools..."
    xcode-select --install

    echo "--------------------------------------------------------"
    echo "Please complete the installation in the popup window."
    echo "After installation is complete, press Enter to continue."
    echo "--------------------------------------------------------"
    read -r
  fi
fi

# git clone する
REPOSITORY=${REPOSITORY:-"github.com/hatyuki/macbook-provisioning"}
SOURCE_DIR="${HOME}/Sources/${REPOSITORY}"

if [[ ! -d "${SOURCE_DIR}" ]]; then
  git clone "https://${REPOSITORY}.git" "${SOURCE_DIR}"
fi
