# nvim-config

Personal LunarVim config for daily usage.

## Disclaimer

This configuration is tailored exclusively for my personal use, and its public availability is solely for convenient sharing.

Please note that this config is subject to frequent changes, may lack organization, and might not align perfectly with your requirements.

## Installation

1. [Install LunarVim](https://www.lunarvim.org/docs/installation)
2. [Move this config to lvim config path](https://www.lunarvim.org/docs/configuration)
3. Start `lvim`
4. Optional:
   - `:Copilot auth`
   - `:Mason` and install all -> `:LvimCacheReset`

## Docker Setup

Use this command to run this Neovim configuration anywhere on your system inside a Docker container:

> **Note**: Make sure you have Docker and the image installed (`make docker-build`).

```bash
docker run --rm -it \
  -v "$PWD":"$PWD" \
  -w "$PWD" \
  akvim lvim
```

> **Tip**: You can create an alias in your shell configuration file (e.g., `.bashrc`, `.zshrc`) for easier access:

```bash
alias akvim='docker run --rm -it -v "$PWD":"$PWD" -w "$PWD" akvim lvim'

# usage
akvim <file-to-edit>
akvim .
```

## Usage

| Action             | Key(s)             |
| ------------------ | ------------------ |
| Leader             | \<SPACE\>          |
| WhichKeys          | \<LEADER\> + s + k |
| FuzzySearchBuffer  | \<LEADER\> + s + T |
| Make Shortcut      | \<LEADER\> + m     |
| Leap Forward       | s                  |
| Leap Backward      | S                  |
| Select Window      | \<LEADER\> + w     |
| Show documentation | K                  |
