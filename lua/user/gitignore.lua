-- Mark buffer which are gitignored
local function is_gitignored()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then return false end

  local result = vim.fn.systemlist({ "git", "check-ignore", path })
  return #result > 0
end

local function adjust_color(hex, factor)
  local r = tonumber(hex:sub(2, 3), 16)
  local g = tonumber(hex:sub(4, 5), 16)
  local b = tonumber(hex:sub(6, 7), 16)

  r = math.floor(math.max(0, math.min(255, r * factor)))
  g = math.floor(math.max(0, math.min(255, g * factor)))
  b = math.floor(math.max(0, math.min(255, b * factor)))

  return string.format("#%02x%02x%02x", r, g, b)
end

local function get_normal_bg()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  if normal and normal.bg then
    return string.format("#%06x", normal.bg)
  end
  return nil
end

local function update_buffer_background()
  if is_gitignored() then
    local current_bg = get_normal_bg()
    if current_bg then
      local darker_bg = adjust_color(current_bg, 0.85)
      vim.api.nvim_set_hl(0, "GitIgnoredBackground", { bg = darker_bg })
      vim.wo.winhighlight = "Normal:GitIgnoredBackground"
    end
  else
    vim.wo.winhighlight = ""
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufWritePost", "ColorScheme" }, {
  callback = function()
    update_buffer_background()
  end,
})
