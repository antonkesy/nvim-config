return {
  {
    "folke/persistence.nvim",
    opts = {
      -- Keep sessions scoped to each working directory.
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },
    },
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.g.started_with_stdin == 1 then
            return
          end

          local argc = vim.fn.argc()
          local should_restore = argc == 0

          if not should_restore and argc == 1 then
            local arg0 = vim.fn.argv(0)
            should_restore = arg0 ~= nil and vim.fn.isdirectory(arg0) == 1
          end

          if should_restore then
            require("persistence").load()
          end
        end,
      })
    end,
  },
}
