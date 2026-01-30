return {
  "snacks.nvim",
  opts = {
    dashboard = {
      preset = {
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
          hidden = false, -- don't show dotfiles in fuzzy finder
          ignored = true, -- optional: show gitignored files
        },
      },
    },
  },
}
