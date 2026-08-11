-- Custom overlay on top of kickstart.nvim.
--
-- init.lua is stock kickstart with exactly two changes, so it stays easy to
-- re-sync with upstream:
--   1. `vim.g.have_nerd_font = true`   (we install a Nerd Font for Ghostty)
--   2. `require 'custom'`              (was the commented-out `require 'custom.plugins'`)
--
-- Everything that used to live in the old init.vim lives below this point.
-- Load order matters: options first, then plugins (so a plugin can react to an
-- option), then keymaps and autocmds last so they win over plugin defaults.

require 'custom.options'
require 'custom.plugins'
require 'custom.keymaps'
require 'custom.autocmds'
