return {
  {
    "max397574/better-escape.nvim",
    commit="19a38aa",
    config = function()
      require("better_escape").setup {
        timeout = 200, --ms
      }
    end,
  }
}
