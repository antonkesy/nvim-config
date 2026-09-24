return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "markdown.mdx", "norg", "rmd", "org", "quarto", "codecompanion", "Avante" },
    opts = {
      file_types = { "markdown", "markdown.mdx", "norg", "rmd", "org", "quarto", "codecompanion", "Avante" },
      completions = { blink = { enabled = true } },
      -- keep the gutter free for gitsigns and diagnostics
      sign = { enabled = false },
      heading = {
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        position = "overlay",
        width = "full",
      },
      code = {
        style = "full",
        width = "block",
        border = "thin",
        left_pad = 2,
        right_pad = 2,
      },
      checkbox = { enabled = true },
      pipe_table = { preset = "round" },
    },
  },
}
