-- Plugins that kickstart does not ship, installed with `vim.pack`
-- (Neovim's built-in plugin manager — see `:help vim.pack`).
--
-- To update everything, including kickstart's own plugins:  :lua vim.pack.update()
-- To see pending updates without hitting the network:       :lua vim.pack.update(nil, { offline = true })

require 'custom.plugins.colors'
require 'custom.plugins.git'
require 'custom.plugins.tpope'
require 'custom.plugins.tree'
require 'custom.plugins.editing'
require 'custom.plugins.gnupg'
require 'custom.plugins.langs'
