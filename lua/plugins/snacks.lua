return {
  "snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          -- luacheck: ignore
          return LazyVim.pick(cmd, opts)()
        end,
        header = io.open("lua/plugins/dashboard.txt", "r"):read("*all"),
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = { },
      },
    },
  },
}
