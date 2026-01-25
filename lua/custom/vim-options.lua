-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- set :terminal to use Fish
vim.o.shell = 'fish'

-- set :titlestring for window
vim.opt.title = true
vim.opt.titlestring = 'v  -  %F  %M'

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For motre options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Disable 'Oo' -> insert mode
vim.keymap.set('n', 'o', 'o<Esc>', { noremap = true, silent = true })
vim.keymap.set('n', 'O', 'O<Esc>', { noremap = true, silent = true })

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true
-- Enable gutter for all files, not only git
vim.o.signcolumn = 'yes'
-- Save undo history
vim.o.undofile = true

-- Specify the directory for undo files
-- It's common practice to use a dedicated directory inside Neovim's data path
local undodir = vim.fn.stdpath 'data' .. '/undo'

-- Create the directory if it doesn't exist
vim.fn.mkdir(undodir, 'p') -- 'p' flag creates parent directories if needed

-- Set the undodir option (it takes a list/table of directories)
vim.opt.undodir = { undodir }

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Sets up the core tab settings
vim.opt.tabstop = 2 -- A TAB displays as 2 spaces
vim.opt.shiftwidth = 2 -- Auto-indent commands (like << or >>) use 2 spaces
vim.opt.softtabstop = 2 -- Backspace and Insert mode tabs/auto-indent treat 2 spaces as one unit

-- Tells Neovim to use spaces when the <Tab> key is pressed
vim.opt.expandtab = true

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Hardware Acceleration
vim.opt.updatetime = 250

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.cmd [[set display+=lastline]]
-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- === Custom Terminal Split Setup ===
-- settings the default shell
vim.opt.shell = '/bin/bash'
-- Define a custom function to open a horizontal terminal split with fixed height
local function open_terminal_split_fixed(height)
  -- Default to 10 lines if no height is specified
  height = height or 10

  -- 1. Use the height to pre-set the window size before creating the split.
  -- The syntax "[N]split" creates a horizontal split N lines high.
  local split_command = tostring(height) .. ' split'
  vim.cmd(split_command)

  -- 2. Open the terminal buffer in the newly created window.
  -- This is the standard way to launch a terminal in Neovim.
  vim.cmd 'terminal fish'

  -- 3. Optionally enter insert mode immediately so you can start typing commands.
  vim.cmd 'startinsert'
end

-- Create a user command to easily access the function: :TermSplit10
vim.api.nvim_create_user_command('TermSplit10', function()
  open_terminal_split_fixed(10)
end, {
  desc = 'Opens a horizontal terminal split with a fixed height of 10 lines.',
})

-- Example Keymap: <leader>tT
vim.keymap.set('n', '<leader>tT', function()
  open_terminal_split_fixed(10)
end, { noremap = true, silent = true, desc = 'Open fixed-height terminal split' })

-- =====================================

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 500

-- set rounded border for all floating windows
vim.o.winborder = 'rounded'

-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- 2. Define the toggle state (default to ON)
local auto_hover_diagnostics = false

-- 3. Define the function to open the float window, checking the toggle
local function toggleable_diagnostic_float()
  if auto_hover_diagnostics then
    -- Open the diagnostic float window only if the toggle is ON
    vim.diagnostic.open_float(nil, {
      focus = false,
      -- You can also add a delay here, though updatetime is usually sufficient
    })
  end
end

-- 4. Define the function to toggle the state and provide feedback
local function toggle_diagnostics()
  auto_hover_diagnostics = not auto_hover_diagnostics
  local status = auto_hover_diagnostics and 'ON' or 'OFF'

  -- Display a message confirming the change
  vim.notify('Auto-hover diagnostics Toggled: ' .. status, vim.log.levels.INFO)
end

-- 5. Define the AutoCommands (Autocmds) that use the toggle function
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  callback = toggleable_diagnostic_float,
})

-- 6. Define a keybinding to toggle the behavior
-- Example: <leader>D will toggle auto-hover diagnostics ON/OFF
vim.keymap.set('n', '<leader>D', toggle_diagnostics, {
  desc = 'Toggle Auto-Hover Diagnostics',
  silent = true,
})
