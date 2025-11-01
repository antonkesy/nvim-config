return {
  {
    'rmagatti/goto-preview',
    commit = "b5eb40a",
    config = function()
      require('goto-preview').setup {
        default_mappings = true,
        dismiss_on_move = true,
        focus_on_open = false
      }
    end
  }
}
