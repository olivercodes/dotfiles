-- Options ported from the old init.vim.
-- These load after kickstart's own option block, so anything set here wins.

local opt = vim.opt

-- -------------------------------------
--  Search
-- -------------------------------------

-- The old init.vim set `smartcase` with no `ignorecase`. smartcase is a no-op
-- without it, so case-insensitive search never actually worked. Both are set here.
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- -------------------------------------
--  Appearance
-- -------------------------------------

opt.background = 'dark'
opt.number = true
opt.relativenumber = true
opt.numberwidth = 5
opt.cursorline = true
opt.wrap = false
opt.showcmd = true
opt.signcolumn = 'yes'
opt.listchars = { nbsp = '_', trail = '.', tab = '  ' }
-- opt.list = true

-- Old init.vim had `set t_Co=256` and `set t_vb=`. Termcap options do not exist
-- in Neovim and were silently doing nothing; truecolor is on by default.
opt.errorbells = false
opt.visualbell = false

-- -------------------------------------
--  Text / indentation
-- -------------------------------------

opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.joinspaces = false
opt.diffopt:append 'vertical'

-- NOTE: kickstart ships guess-indent.nvim, which detects a file's actual
-- indentation and overrides the values above per-buffer. That is usually what
-- you want; the settings above are the fallback for new/ambiguous files.
-- To turn it off entirely, remove the guess-indent block from init.lua.

-- -------------------------------------
--  Files & backups
-- -------------------------------------

opt.backup = false
opt.writebackup = false
opt.swapfile = false
-- kickstart enables `undofile`, which is strictly better than the old setup:
-- persistent undo across sessions without leaving .swp litter. Left enabled.

opt.wildignore:append {
  '*.db', '*.o', '*.obj',
  '*.swp', '*.bak', '*.lock',
  '*.git', '*.svn',
  '*DS_Store*',
  '**/tmp/**',
  '*.png', '*.jpg', '*.gif',
  '*.app', '*.dmg', '*.pdf', '*.so',
}

-- -------------------------------------
--  Misc
-- -------------------------------------

opt.hidden = true
opt.mouse = 'a'

-- `set tm=500` in the old config. kickstart defaults to 300, which makes
-- which-key pop up faster; raise or lower to taste.
opt.timeoutlen = 500

opt.updatetime = 300
opt.shortmess:append 'c'

-- Dropped from the old init.vim on purpose:
--   set cmdheight=2        -- only existed to give coc.nvim room for messages
--   set completeopt-=preview -- blink.cmp manages completeopt itself
--   set magic              -- already the Neovim default
--   filetype plugin indent on -- already the Neovim default
