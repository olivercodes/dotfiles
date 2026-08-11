-- Git.
--
-- kickstart already ships gitsigns, which replaces vim-gitgutter (including the
-- old :GitGutter* toggles — see :help gitsigns). fugitive is the piece kickstart
-- has no equivalent for.

vim.pack.add { 'https://github.com/tpope/vim-fugitive' }

local map = vim.keymap.set

map('n', '<leader>gs', '<cmd>Git<cr>', { desc = 'Git status' })
map('n', '<leader>gb', '<cmd>Git blame<cr>', { desc = 'Git blame' })
map('n', '<leader>gd', '<cmd>Gvdiffsplit<cr>', { desc = 'Git diff (split)' })
map('n', '<leader>gc', '<cmd>Git commit<cr>', { desc = 'Git commit' })
