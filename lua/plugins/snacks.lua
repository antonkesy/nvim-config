return {
  "snacks.nvim",
  opts = {
    terminal = {
      win = {
        position = "float",
        width = 0, -- 0 = full width
        height = 0, -- 0 = full height
        row = 0,
        col = 0,
        border = "none",
        backdrop = false,
      },
    },
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
          ignored = false, -- optional: show gitignored files
        },
      },
    },
  },
}
