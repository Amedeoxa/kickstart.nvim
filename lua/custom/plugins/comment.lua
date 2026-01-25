return {
  'numToStr/Comment.nvim',
  lazy = false, -- Load it immediately
  config = function()
    require('Comment').setup {
      -- Optional: Use gC to toggle a block comment
      toggler = {
        line = 'gc', -- Default: gc
        block = 'gbc', -- Default: gbc
      },
      -- Optional: Extra mappings to quickly comment/uncomment
      opleader = {
        line = 'gc',
        block = 'gbc',
      },
      -- Optional: What characters to ignore when determining comment type
      extra = {
        -- add comment to empty lines
        comment_empty = false,
      },
      -- Add a custom keymap to your leader
      keymaps = {
        line = '<leader>/', -- A very common and easy-to-reach toggle map
        block = '<leader>cb',
      },
    }
  end,
}
