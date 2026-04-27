return {
  {
    "ThePrimeagen/refactoring.nvim",
    optional = true,
    dependencies = {
      "lewis6991/async.nvim",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = { enabled = false },
        nixd = {},
      },
    },
  },
}
