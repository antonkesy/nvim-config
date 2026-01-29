return {
  "snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          -- luacheck: ignore
          return LazyVim.pick(cmd, opts)()
        end,
        header = "¯\\_(ツ)_/¯",
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = { },
      },
    },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
        },
        files = {
          hidden = true, -- show dotfiles in fuzzy finder
          ignored = true, -- optional: show gitignored files
        },
      },
    },
  },
}
