ARG BASE_IMAGE=ubuntu:24.04
FROM ${BASE_IMAGE} AS base

ARG USERNAME=akvim

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update -y && apt-get install -y git locales tzdata sudo build-essential

RUN groupadd -r ${USERNAME} && useradd -m -r -g ${USERNAME} ${USERNAME}
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USERNAME}

WORKDIR /home/${USERNAME}

# build Neovim from source
RUN git clone --depth 1 --branch v0.10.4 https://github.com/neovim/neovim
WORKDIR /home/${USERNAME}/neovim
RUN sudo apt-get install -y ninja-build gettext cmake unzip curl cmake
RUN make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install

WORKDIR /home/${USERNAME}
# Install NVM
RUN sudo apt-get install curl ca-certificates -y
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN sudo apt-get install -y nodejs

# Install newer Rust
RUN sudo apt-get install -y rustup
RUN rustup default stable
RUN sudo apt-get -y install libgit2-dev libcurl4-openssl-dev libssh-dev libssl-dev pkgconf
RUN cargo install cargo-update

# Install LunarVim
RUN	sudo apt-get install -y git make pip python3-dev python3-venv npm ripgrep
RUN sudo rm /usr/lib/python3.12/EXTERNALLY-MANAGED -f
RUN bash -c "LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh) --no-interaction --yes"
ENV PATH="$PATH:/home/${USERNAME}/.local/bin"

# LSP Dependencies
RUN sudo apt-get install -y npm ruby-dev r-base php libapache2-mod-php php-cli php-cgi unzip llvm-14 lldb-14 libhunspell-dev

# Config
WORKDIR /home/${USERNAME}
COPY --chown=akvim:akvim . /home/${USERNAME}/.config/nvim

# Install plugins
RUN nvim --headless -c "Lazy sync" -c "qa"

# Install all parsers headless (this might take a while)
RUN nvim --headless \
  -c 'lua for _,lang in ipairs(require("nvim-treesitter.parsers").available_parsers()) do vim.cmd("TSInstallSync " .. lang) end' \
  -c 'qa'
