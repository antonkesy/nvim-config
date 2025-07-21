-- https://github.com/mfussenegger/nvim-lint
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  { name = "actionlint" }, -- GitHub Actions linter
  { name = "alex" },       -- Text linter for inclusive language
  -- TODO: not in Mason { name = "ameba" },         -- Crystal lang
  -- TODO: not in Mason { name = "ansible_lint" },  -- Ansible
  { name = "bandit" },     -- Python security issues
  { name = "buf" },        -- Protobuf
  { name = "buildifier" }, -- Bazel
  -- { name = "checkmake" },  -- Make
  -- TODO: not in Mason { name = "checkpatch" },    -- Git Patch
  { name = "checkstyle" }, -- Java
  { name = "chktex" },     -- TeX
  -- TODO: not in Mason { name = "clangtidy" },     -- clangtidy
  -- TODO: not in Mason { name = "clippy" },        -- Rust code improvements
  -- FIXME { name = "bacon" },         -- Rust code improvements
  -- FIXME { name = "cmakelint" },     -- CMake
  -- FIXME { name = "cmakelang" },     -- CMake
  -- { name = "codespell" },     -- common misspellings
  { name = "credo" },         -- Elixir
  { name = "dotenv_linter" }, -- .env
  { name = "flake8" },        -- Python
  { name = "gitlint" },       -- Git commit message linter
  -- FIXME: { name = "gdtoolkit" },     -- Godot
  -- FIXME: { name = "hlint" },         -- Haskell source code suggestions
  -- FIXME { name = "htmlhint" }, -- HTML
  -- FIXME { name = "joker" },    -- Clojure
  { name = "jshint" },   -- JavaScript Hint
  { name = "jsonlint" }, -- JSON
  { name = "ktlint" },   -- Kotlin
  -- TODO: not in Mason { name = "lacheck" },       -- Latex
  -- TODO: not in Mason { name = "languagetool" },  -- Language/Grammar
  { name = "luacheck" },     -- Lua
  { name = "markdownlint" }, -- Markdown
  { name = "protolint" },    -- Protobuf
  { name = "ruff" },         -- Python Linter (in Rust)
  -- FIXME { name = "yq" },           -- YAML
  { name = "zsh" },          -- zsh
  { name = "proselint" },    -- Prose
  {
    name = "shellcheck",     -- shell (sh,bash, but no zsh (with workaround kinda))
    filetypes = { "sh", "zsh", "bash" },
    args = { "--severity", "warning", "--shell", "bash" },
  },
  -- FXIME { name = "shellharden" }, -- shell
  { name = "sqlfluff" }, -- SQL
  { name = "yamllint" }, -- YAML
  -- {
  --   name = "vale"
  --   args = { "configPath=~/.config/vale/vale.ini" },
  -- }""
  -- FIXME { name = "wasm-language-tools" },
  { name = "trivy" } -- Container security scanner
})
