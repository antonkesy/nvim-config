return {
  { "rafamadriz/friendly-snippets", enabled = false },
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.default = vim.tbl_filter(function(source)
        return source ~= "snippets"
      end, opts.sources.default or {})

      -- drop snippet items served by language servers
      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.lsp = vim.tbl_deep_extend("force", opts.sources.providers.lsp or {}, {
        transform_items = function(_, items)
          local snippet = require("blink.cmp.types").CompletionItemKind.Snippet
          return vim.tbl_filter(function(item)
            return item.kind ~= snippet
          end, items)
        end,
      })
    end,
  },
}
