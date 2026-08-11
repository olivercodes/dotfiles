-- Transparent editing of gpg-encrypted files.
--
-- Kept because zshrc sets GPG_TTY and daemonizes gpg-agent, so gpg is clearly
-- still in the workflow. Opening a .gpg/.asc/.pgp file decrypts it in memory,
-- and writing re-encrypts to the same recipients.
--
-- Note this plugin sets 'noswapfile'/'nobackup' for those buffers itself, which
-- is already the global default in options.lua.

vim.pack.add { 'https://github.com/jamessan/vim-gnupg' }
