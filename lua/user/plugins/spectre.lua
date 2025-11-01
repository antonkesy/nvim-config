return {
  {
    -- TODO: how to use?
    "windwp/nvim-spectre",
    commit = "72f56f7",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  }
}
