-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Show what actually is there, not some special render
vim.opt.conceallevel = 0

-- Don't autoformat on save
vim.g.autoformat = false

-- Don't jump to repo root if opened in subdir
vim.g.root_spec = { "cwd" }
