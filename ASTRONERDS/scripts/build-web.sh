#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
emsdk_version="3.1.74"
emsdk_root="${EMSDK_ROOT:-${TMPDIR:-/tmp}/horizon-emsdk-${emsdk_version}}"

if [[ ! -x "${emsdk_root}/upstream/emscripten/emcc" ]]; then
  if [[ ! -d "${emsdk_root}/.git" ]]; then
    git clone --depth 1 --branch "${emsdk_version}" https://github.com/emscripten-core/emsdk.git "${emsdk_root}"
  fi
  "${emsdk_root}/emsdk" install "${emsdk_version}"
fi

"${emsdk_root}/emsdk" activate "${emsdk_version}"
# shellcheck disable=SC1091
source "${emsdk_root}/emsdk_env.sh" >/dev/null

mkdir -p "${project_dir}/dist"
cd "${project_dir}"
em++ -std=c++17 -O2 -Iinclude \
  -DHORIZON_HAS_SDL=1 -DHORIZON_WEB_BUILD=1 \
  -sUSE_SDL=2 -sASYNCIFY -sALLOW_MEMORY_GROWTH=1 \
  --shell-file web/shell.html \
  --preload-file assets@/assets \
  src/*.cpp -o dist/index.html
