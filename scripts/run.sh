#!/bin/bash

set -eux -o pipefail

cargo build

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export NVIM_LOG_FILE="${SCRIPT_DIR}/../test/logs/nvim.log"

mkdir -p $(dirname ${NVIM_LOG_FILE})

nvim -u ${SCRIPT_DIR}/../test/config/lazy-init.lua
