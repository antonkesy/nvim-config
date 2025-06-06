return {
  {
    "ttibsi/pre-commit.nvim",
    config = function()
      lvim.builtin.which_key.mappings["p"] = {
        ":Precommit<CR>", "Pre-Commit",
      }
    end,
  }
}
