-- File explorer.
--
-- The old config installed kyazdani42/nvim-tree.lua (that org is now nvim-tree/)
-- and configured it with `g:nvim_tree_auto_open`. Those globals were removed in
-- 2022, and the plugin was never `.setup()`'d, so it had been doing nothing at
-- all. This is the working equivalent.
--
-- kickstart ships neo-tree as an optional example instead, but it's commented
-- out and we're staying with nvim-tree to match the old setup.

vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-tree/nvim-tree.lua',
}

-- Recommended by nvim-tree: disable netrw so the two don't fight over directories.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup {
  hijack_cursor = true,
  view = { width = 35 },
  renderer = { group_empty = true },
  filters = { dotfiles = false },
  update_focused_file = { enable = true },
}

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<leader>E', '<cmd>NvimTreeFindFile<cr>', { desc = 'Reveal current file in explorer' })
