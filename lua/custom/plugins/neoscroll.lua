-- Smooth scrolling for window movement commands
return {
  'karb94/neoscroll.nvim',
  config = function()
    require('neoscroll').setup {
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
      hide_cursor = true,
      stop_eof = false,
      respect_eof = false,
      cursor_scrolls_all_de_way = false,
      easing_function = 'quadratic',
      duration_multiplier = 0.5,
    }
  end,
}
