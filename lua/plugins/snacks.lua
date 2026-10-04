-- Yank the selected explorer files, each transformed by `fmt`.
---@param picker snacks.Picker
---@param fmt fun(path: string): string
local function explorer_yank(picker, fmt)
  local files = {} ---@type string[]
  if vim.fn.mode():find("^[vV]") then
    picker.list:select()
  end
  for _, item in ipairs(picker:selected({ fallback = true })) do
    table.insert(files, fmt(Snacks.picker.util.path(item)))
  end
  picker.list:set_selected() -- clear selection
  vim.fn.setreg(vim.v.register or "+", table.concat(files, "\n"), "l")
  Snacks.notify.info("Yanked " .. #files .. " files")
end

return {
  "snacks.nvim",
  opts = {
    terminal = {
      win = {
        position = "float",
        width = 0, -- full width
        -- full height minus the statusline and cmdline, so the nvim
        -- statusline stays visible under the float
        height = function()
          return math.max(vim.o.lines - vim.o.cmdheight - 1, 1)
        end,
        row = 0,
        col = 0,
        border = "none",
        backdrop = false,
      },
    },
    dashboard = {
      preset = {
        header = "¯\\_(ツ)_/¯",
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = { },
      },
    },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          actions = {
            -- y: yank file name(s), Y: yank absolute path(s)
            explorer_yank_name = function(picker)
              explorer_yank(picker, vim.fs.basename)
            end,
            explorer_yank_abs = function(picker)
              explorer_yank(picker, function(path)
                return vim.fn.fnamemodify(path, ":p")
              end)
            end,
          },
          win = {
            list = {
              keys = {
                ["y"] = { "explorer_yank_name", mode = { "n", "x" } },
                ["Y"] = { "explorer_yank_abs", mode = { "n", "x" } },
              },
            },
          },
        },
        files = {
          hidden = false, -- don't show dotfiles in fuzzy finder
          ignored = false, -- optional: show gitignored files
        },
      },
    },
  },
}
