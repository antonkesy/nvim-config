return {
  "snacks.nvim",
  opts = {
    terminal = {
      win = {
        position = "float",
        width = 0, -- full width
        -- full height minus the statusline and cmdline, so the nvim
        -- statusline stays visible under the float
        height = function()
          return math.max(vim.o.lines - vim.o.cmdheight - 1, 1)
        end,
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
