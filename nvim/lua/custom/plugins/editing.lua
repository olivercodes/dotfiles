-- Editing niceties.

-- Indent guides — replaces nathanaelkane/vim-indent-guides, which the old
-- config had a TODO next to saying it could never be made to work.
-- (kickstart has this as kickstart.plugins.indent_line, but that's a separate
-- file from the repo which we don't vendor, so it's installed directly here.)
vim.pack.add { 'https://github.com/lukas-reineke/indent-blankline.nvim' }

require('ibl').setup {
  indent = { char = '│' },
  scope = { enabled = false },
}

-- splitjoin.vim -> mini.splitjoin. mini.nvim is already installed by kickstart,
-- so this is just switching on another of its modules rather than a new plugin.
-- gS to split a one-liner across lines, gJ to join it back.
require('mini.splitjoin').setup {
  mappings = { toggle = '', split = 'gS', join = 'gJ' },
}
