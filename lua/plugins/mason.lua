return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "harper-ls",
    },
    -- handlers = {
    --   ["harper-ls"] = function()
    --     require("lspconfig").harper.setup({
    --       filetypes = { "markdown", "tex" },
    --       settings = {
    --         harper = {
    --           lintComments = true, -- enable checking inside comments
    --         },
    --       },
    --     })
    --   end,
    -- },
  },
}
