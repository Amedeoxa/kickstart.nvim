return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'
    local config_dir = vim.fn.stdpath 'config'
    local custom_dir = config_dir .. '/lua/custom'
    local all_config_dir = config_dir .. '/../'
    -- Set header
    dashboard.section.header.val = {
      [[ ┌─────────────────────────────────────────────────────────────────┐ ]],
      [[ │                     ,                                           │ ]],
      [[ │                     \`-._           __                          │ ]],
      [[ │                      \\  \-..____,.'  `.                        │ ]],
      [[ │                       :  )       :      :\                      │ ]],
      [[ │                        ;'        '   ;  | :                     │ ]],
      [[ │                        )..      .. .:.`.; :                     │ ]],
      [[ │                       /::...  .:::...   ` ;                     │ ]],
      [[ │                       `:Ω>   /\Ω_>        : `.                  │ ]],
      [[ │                      `-`.__ ;   __..--- /:.   \                 │ ]],
      [[ │                     ==== \_/   ;=====_.':.     ;                │ ]],
      [[ │                       ,/'`--'...`--....        ;                │ ]],
      [[ │                            ;                    ;               │ ]],
      [[ │                        . '                       ;              │ ]],
      [[ │                      .'     ..     ,      .       ;             │ ]],
      [[ │                     :       ::..  /      ;::.     |             │ ]],
      [[ │                    /      `.;::.  |       ;:..    ;             │ ]],
      [[ │                   :         |:.   :       ;:.    ;              │ ]],
      [[ │                   :         ::     ;:..   |.    ;               │ ]],
      [[ │                    :       :;      :::....|     |               │ ]],
      [[ │                    /\     ,/ \      ;:::::;     ;               │ ]],
      [[ │                  .:. \:..|    :     ; '.--|     ;               │ ]],
      [[ │                 ::.  :''  `-.,,;     ;'   ;     ;               │ ]],
      [[ │              .-'. _.'\      / `;      \,__:      \              │ ]],
      [[ │              `---'    `----'   ;      /    \,.,,,/              │ ]],
      [[ │                                 `----`                          │ ]],
      [[ └─────────────────────────────────────────────────────────────────┘ ]],
      [[                              Neovim                                 ]],
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button('f', '󰈞   Find file', ':Telescope find_files <CR>'),
      dashboard.button('r', '   Recent', ':Telescope oldfiles<CR>'),
      -- dashboard.button('c', '   NVIM Config', ':edit ' .. config_dir .. '/init.lua <CR>'),
      -- NEW: Open your plugin directory (assuming you use a lua/plugins structure)
      -- dashboard.button('p', '   Plugins Folder', ':edit ' .. config_dir .. '/lua/plugins/init.lua <CR>'),
      -- -- We use a Lua function to call Telescope with the 'cwd' (Current Working Directory) set.
      dashboard.button('p', '   Find Plugin Config (nvim)', function()
        if require 'telescope' then
          local actions = require 'telescope.actions'
          local action_state = require 'telescope.actions.state'

          -- Function to create a new file
          local custom_create_file = function(prompt_bufnr)
            local search_query = action_state.get_current_line()
            actions.close(prompt_bufnr)
            -- The file will be created in the 'custom_dir' context
            vim.cmd('e ' .. custom_dir .. '/' .. search_query)
          end

          require('telescope.builtin').find_files {
            cwd = custom_dir,
            prompt_title = ' CUSTOM CONFIG FILES ',

            -- MINIMUM CODE STARTS HERE: Define keybindings for this specific picker
            attach_mappings = function(prompt_bufnr)
              -- Map Ctrl-N in both Normal and Insert mode to the file creation function
              vim.keymap.set({ 'n', 'i' }, '<C-a>', function()
                custom_create_file(prompt_bufnr)
              end, { buffer = prompt_bufnr, desc = 'Create New File' })

              return true
            end,
            -- MINIMUM CODE ENDS HERE
          }
        end
      end),
      dashboard.button('c', '   Find Config ( all )', function()
        if require 'telescope' then
          local actions = require 'telescope.actions'
          local action_state = require 'telescope.actions.state'

          -- Function to create a new file
          local custom_create_file = function(prompt_bufnr)
            local search_query = action_state.get_current_line()
            actions.close(prompt_bufnr)
            -- The file will be created in the 'custom_dir' context
            vim.cmd('e ' .. all_config_dir .. '/' .. search_query)
          end

          require('telescope.builtin').find_files {
            cwd = all_config_dir,
            prompt_title = ' ALL CONFIG (~/.config ) ',

            -- MINIMUM CODE STARTS HERE: Define keybindings for this specific picker
            attach_mappings = function(prompt_bufnr)
              -- Map Ctrl-N in both Normal and Insert mode to the file creation function
              vim.keymap.set({ 'n', 'i' }, '<C-a>', function()
                custom_create_file(prompt_bufnr)
              end, { buffer = prompt_bufnr, desc = 'Create New File' })

              return true
            end,
            -- MINIMUM CODE ENDS HERE
          }
        end
      end),
      dashboard.button('e', '   New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('q', '󰩈   Quit NVIM', ':qa<CR>'),
    }

    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd [[ autocmd FileType alpha setlocal nofoldenable ]]
    -- This checks if lualine is installed and then disables it for the 'alpha' filetype.
    if package.loaded['lualine'] then
      vim.cmd [[ autocmd FileType alpha setlocal laststatus=0 ]]
    end
  end,
}
