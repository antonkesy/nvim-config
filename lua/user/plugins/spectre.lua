return {
  {
    -- TODO: how to use?
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  }
}
