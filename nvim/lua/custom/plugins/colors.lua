-- Colorscheme.
--
-- kickstart installs and applies tokyonight in its UI section. This runs after
-- that and overrides it, so tokyonight stays available (`:colorscheme tokyonight`)
-- but Oceanic Next is what loads at startup — matching `theme = Oceanic Next`
-- in ghostty/config so the terminal and editor backgrounds line up.
--
-- The old dein spec had `{'build': './install.sh'}`, which only generated iTerm
-- and Terminal.app color profiles. Ghostty has the theme built in, so it's dropped.

vim.pack.add { 'https://github.com/mhartington/oceanic-next' }

vim.g.oceanic_next_terminal_bold = true
vim.g.oceanic_next_terminal_italic = true

vim.cmd.colorscheme 'OceanicNext'
