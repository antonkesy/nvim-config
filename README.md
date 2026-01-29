# nvim-config

Personal LazyVim config for daily usage.

## Disclaimer

This configuration is tailored exclusively for my personal use, and its public availability is solely for convenient sharing.

Please note that this config is subject to frequent changes, may lack organization, and might not align perfectly with your requirements.

## Installation

2. [Move this config to nvim config path (`~/.config/nvim`)](https://www.lazyvim.org/installation)
3. Start `nvim`
4. Optional:
   - `:Copilot auth`
   - `:Mason`

## Docker Setup

Use this command to run this Neovim configuration anywhere on your system inside a Docker container:

> **Note**: Make sure you have Docker and the image installed (`make docker-build`).

```bash
docker run --rm -it \
  -v "$PWD":"$PWD" \
  -w "$PWD" \
  akvim nvim
```

> **Tip**: You can create an alias in your shell configuration file (e.g., `.bashrc`, `.zshrc`) for easier access:

```bash
alias akvim='docker run --rm -it -v "$PWD":"$PWD" -w "$PWD" akvim nvim'

# usage
akvim <file-to-edit>
akvim .
```

## Usage

- [Keymaps](https://www.lazyvim.org/keymaps)
