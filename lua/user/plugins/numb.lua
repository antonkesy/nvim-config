return {
  {
    -- peek line numbers when entering a command
    'nacro90/numb.nvim',
    commit = '7f564e6',
    config = function()
      require('numb').setup()
    end
  }
}
