-- The tpope plugins kickstart leaves out.
--
-- Not carried over, because kickstart's mini.nvim already covers them:
--   vim-surround   -> mini.surround
--   vim-commentary -> built into Neovim 0.10+ as `gc` / `gcc`
--   targets.vim    -> mini.ai
--   matchit        -> ships enabled with Neovim

vim.pack.add {
  -- [f ]f to walk files in a directory, [os ]os =os to toggle options,
  -- [b ]b for buffers, [q ]q for the quickfix list.
  'https://github.com/tpope/vim-unimpaired',

  -- :Rename :Delete :Unlink :Chmod :SudoWrite :SudoEdit
  'https://github.com/tpope/vim-eunuch',

  -- Makes `.` repeat whole plugin mappings rather than the last native command.
  'https://github.com/tpope/vim-repeat',

  -- :Obsess to start recording a session, :Obsess! to discard, `nvim -S` to load.
  'https://github.com/tpope/vim-obsession',
}
