#!/usr/bin/env bash
set -euo pipefail

NVIM_VERSION="${NVIM_VERSION:-v0.11.6}"
INSTALL_PLUGINS="${INSTALL_PLUGINS:-1}"
NVIM_CONFIG_DIR="${NVIM_CONFIG_DIR:-$HOME/.config/nvim}"
NVIM_CONFIG_REPO="${NVIM_CONFIG_REPO:-https://github.com/antonkesy/nvim-config.git}"
NVIM_CONFIG_REF="${NVIM_CONFIG_REF:-}"
UPDATE_EXISTING_CONFIG="${UPDATE_EXISTING_CONFIG:-1}"

if [[ "${EUID}" -eq 0 ]]; then
  SUDO=""
else
  if command -v sudo >/dev/null 2>&1; then
    SUDO="sudo"
  else
    echo "Error: script requires root privileges or sudo." >&2
    exit 1
  fi
fi

log() {
  echo "[nvim-deps] $*"
}

bootstrap_nvim_config() {
  mkdir -p "$(dirname "${NVIM_CONFIG_DIR}")"

  if [[ -d "${NVIM_CONFIG_DIR}" ]]; then
    if [[ "${UPDATE_EXISTING_CONFIG}" != "1" ]]; then
      log "Config directory already exists, skipping update: ${NVIM_CONFIG_DIR}"
      return
    fi

    if [[ -d "${NVIM_CONFIG_DIR}/.git" ]]; then
      log "Updating existing config clone in ${NVIM_CONFIG_DIR}"
      git -C "${NVIM_CONFIG_DIR}" fetch --all --tags --prune
      if [[ -n "${NVIM_CONFIG_REF}" ]]; then
        git -C "${NVIM_CONFIG_DIR}" checkout "${NVIM_CONFIG_REF}"
        git -C "${NVIM_CONFIG_DIR}" pull --ff-only origin "${NVIM_CONFIG_REF}"
      else
        CURRENT_BRANCH="$(git -C "${NVIM_CONFIG_DIR}" symbolic-ref --short HEAD)"
        git -C "${NVIM_CONFIG_DIR}" pull --ff-only origin "${CURRENT_BRANCH}"
      fi
      return
    fi

    echo "Error: NVIM_CONFIG_DIR exists but is not a git repo: ${NVIM_CONFIG_DIR}" >&2
    echo "Set NVIM_CONFIG_DIR to an empty path or remove the directory and re-run." >&2
    exit 1
  fi

  log "Cloning Neovim config into ${NVIM_CONFIG_DIR}"
  if [[ -n "${NVIM_CONFIG_REF}" ]]; then
    git clone --depth 1 --branch "${NVIM_CONFIG_REF}" "${NVIM_CONFIG_REPO}" "${NVIM_CONFIG_DIR}"
  else
    git clone --depth 1 "${NVIM_CONFIG_REPO}" "${NVIM_CONFIG_DIR}"
  fi
}

apt_install() {
  ${SUDO} apt-get install -y --no-install-recommends "$@"
}

version_ge() {
  # Returns success if version $1 >= version $2
  dpkg --compare-versions "$1" ge "$2"
}

export DEBIAN_FRONTEND=noninteractive

log "Updating apt indexes"
${SUDO} apt-get update -y

log "Installing base packages"
apt_install \
  ca-certificates \
  curl \
  git \
  gnupg \
  locales \
  make \
  build-essential \
  sudo \
  tzdata \
  software-properties-common

log "Bootstrapping Neovim config"
bootstrap_nvim_config

log "Configuring locale"
${SUDO} locale-gen en_US.UTF-8 || true

log "Installing Neovim build dependencies"
apt_install \
  ninja-build \
  gettext \
  cmake \
  unzip

log "Installing editor/runtime dependencies"
apt_install \
  ripgrep \
  fd-find \
  fzf \
  xclip \
  python3 \
  python3-pip \
  python3-venv \
  python3-dev \
  luarocks

log "Installing LSP/toolchain dependencies"
apt_install \
  ruby-dev \
  r-base \
  php \
  php-cli \
  php-cgi \
  libapache2-mod-php \
  llvm-14 \
  lldb-14 \
  libhunspell-dev \
  libgit2-dev \
  libcurl4-openssl-dev \
  libssh-dev \
  libssl-dev \
  pkgconf

log "Installing Node.js 20"
if command -v node >/dev/null 2>&1; then
  NODE_VERSION="$(node -v | sed 's/^v//')"
  if version_ge "${NODE_VERSION}" "20.0.0"; then
    log "Node.js ${NODE_VERSION} already installed, skipping"
  else
    log "Node.js ${NODE_VERSION} detected (<20), upgrading"
    curl -fsSL https://deb.nodesource.com/setup_20.x | ${SUDO} -E bash -
    apt_install nodejs
  fi
else
  curl -fsSL https://deb.nodesource.com/setup_20.x | ${SUDO} -E bash -
  apt_install nodejs
fi

log "Installing Rust via rustup"
if ! command -v rustup >/dev/null 2>&1; then
  curl https://sh.rustup.rs -sSf | bash -s -- -y
fi

# shellcheck disable=SC1090
source "$HOME/.cargo/env"
rustup default stable

if ! command -v cargo-install-update >/dev/null 2>&1; then
  cargo install cargo-update
fi

log "Checking Neovim version"
NEED_NVIM_BUILD=1
if command -v nvim >/dev/null 2>&1; then
  INSTALLED_NVIM="$(nvim --version | head -n1 | awk '{print $2}' | sed 's/^v//')"
  TARGET_NVIM="$(echo "${NVIM_VERSION}" | sed 's/^v//')"
  if version_ge "${INSTALLED_NVIM}" "${TARGET_NVIM}"; then
    NEED_NVIM_BUILD=0
    log "Neovim ${INSTALLED_NVIM} already satisfies target ${TARGET_NVIM}, skipping build"
  fi
fi

if [[ "${NEED_NVIM_BUILD}" -eq 1 ]]; then
  log "Building Neovim ${NVIM_VERSION} from source"
  BUILD_DIR="$(mktemp -d)"
  git clone --depth 1 --branch "${NVIM_VERSION}" https://github.com/neovim/neovim "${BUILD_DIR}/neovim"
  pushd "${BUILD_DIR}/neovim" >/dev/null
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  ${SUDO} make install
  popd >/dev/null
  rm -rf "${BUILD_DIR}"
fi

if [[ "${INSTALL_PLUGINS}" == "1" ]]; then
  if [[ ! -d "${NVIM_CONFIG_DIR}" ]]; then
    echo "Error: NVIM_CONFIG_DIR not found: ${NVIM_CONFIG_DIR}" >&2
    exit 1
  fi

  log "Installing plugins with Lazy"
  nvim --headless -u "${NVIM_CONFIG_DIR}/init.lua" -c "Lazy sync" -c "qa"

  log "Installing all available treesitter parsers"
  nvim --headless -u "${NVIM_CONFIG_DIR}/init.lua" \
    -c 'lua for _,lang in ipairs(require("nvim-treesitter.parsers").available_parsers()) do vim.cmd("TSInstallSync " .. lang) end' \
    -c 'qa'
fi

log "Cleaning apt cache"
${SUDO} apt-get clean
${SUDO} rm -rf /var/lib/apt/lists/*

log "Done"
