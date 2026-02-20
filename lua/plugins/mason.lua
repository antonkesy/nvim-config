return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "harper_ls",
    },
    -- handlers = {
    --   ["harper_ls"] = function()
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
