return {
  {
    "yetone/avante.nvim",
    opts = {
      provider = "copilot", -- default
      providers = {
        copilot = {},
        ollama = {
          endpoint = "http://127.0.0.1:11434",
          model = "llama3.1:8b",
          models = { -- TODO: set size of models
            "llama3.1",
            "qwen2.5",
            "deepseek-coder",
            "mistral",
            "codellama",
          },
        },
      },
    },
    -- FIXME: workaround for provider picker not working
    keys = {
      { "<leader>apc", "<cmd>AvanteSwitchProvider copilot<CR>", desc = "Switch Avante Provider to Copilot" },
      { "<leader>apo", "<cmd>AvanteSwitchProvider ollama<CR>", desc = "Switch Avante Provider to Ollama" },
    },
  },
}
