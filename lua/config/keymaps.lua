-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gg", function()
    -- luacheck: globals Snacks LazyVim
    Snacks.lazygit({
      cwd = LazyVim.root.git(),
      win = {
        width = 0.999,
        height = 0.999,
        border = "rounded",
      },
    })
  end, { desc = "Lazygit" })
end

-- qucik 'no highlight'
vim.keymap.set("n", "<leader>h", "<cmd>noh<CR>", { desc = "Clear search highlight" })

-- Claude Code terminal toggle
if vim.fn.executable("claude") == 1 then
  map({ "n", "t" }, "<C-Bslash>", function()
    -- luacheck: globals Snacks
    Snacks.terminal.toggle("claude", { cwd = vim.fn.getcwd() })
  end, { desc = "Toggle Claude terminal" })
end
