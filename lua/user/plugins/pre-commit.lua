return {
  {
    "ttibsi/pre-commit.nvim",
    commit = "547fe1a",
    config = function()
      lvim.builtin.which_key.mappings["p"] = {
        ":Precommit<CR>", "Pre-Commit",
      }
    end,
  }
}
